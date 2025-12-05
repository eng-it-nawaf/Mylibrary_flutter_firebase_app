import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// Theme
import 'core/app_theme.dart';

// Core
import 'package:onboarding_app/core/services/shared_prefs_service.dart';

// Data Sources
import 'package:onboarding_app/data/datasources/local/book_local_datasource.dart';
import 'package:onboarding_app/data/datasources/remote/auth_remote_datasource.dart';

// Repositories
import 'package:onboarding_app/data/repositories/auth_repository_impl.dart';
import 'package:onboarding_app/data/repositories/book_repository_impl.dart';

// Use Cases
import 'package:onboarding_app/domain/usecases/auth/login_usecase.dart';
import 'package:onboarding_app/domain/usecases/auth/register_usecase.dart';
import 'package:onboarding_app/domain/usecases/book/add_book_usecase.dart';
import 'package:onboarding_app/domain/usecases/book/get_books_usecase.dart';
import 'package:onboarding_app/domain/usecases/book/delete_book_usecase.dart';

// ViewModels
import 'package:onboarding_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:onboarding_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:onboarding_app/presentation/viewmodels/onboarding_viewmodel.dart';

// Pages
import 'package:onboarding_app/presentation/pages/onboarding/onboarding_page.dart';
import 'package:onboarding_app/presentation/pages/auth/login_page.dart';
import 'package:onboarding_app/presentation/pages/auth/register_page.dart';
import 'package:onboarding_app/presentation/pages/book/book_list_page.dart';
import 'package:onboarding_app/presentation/pages/book/add_book_page.dart';
import 'package:onboarding_app/presentation/pages/history/history_page.dart';
import 'package:onboarding_app/presentation/pages/profile/profile_page.dart';
import 'package:onboarding_app/presentation/pages/settings/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // تهيئة الخدمات
  final sharedPrefs = SharedPrefsService();
  await sharedPrefs.init();

  // تهيئة مصادر البيانات
  final authRemoteDataSource = AuthRemoteDataSource();
  final bookLocalDataSource = BookLocalDataSource();

  // تهيئة المستودعات
  final authRepo = AuthRepositoryImpl(authRemoteDataSource);
  final bookRepo = BookRepositoryImpl(bookLocalDataSource);

  // تهيئة حالات الاستخدام
  final loginUseCase = LoginUseCase(authRepo);
  final registerUseCase = RegisterUseCase(authRepo);
  final getBooksUseCase = GetBooksUseCase(bookRepo);
  final addBookUseCase = AddBookUseCase(bookRepo);
  final deleteBookUseCase = DeleteBookUseCase(bookRepo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel(sharedPrefs)),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BookViewModel(
            getBooksUseCase: getBooksUseCase,
            addBookUseCase: addBookUseCase,
            deleteBookUseCase: deleteBookUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبتي',
      theme: AppTheme.lightTheme,

      home: Consumer<OnboardingViewModel>(
        builder: (context, onboardingViewModel, child) {
          if (onboardingViewModel.isLoading) {
            return Scaffold(
              backgroundColor: AppTheme.lightTheme.colorScheme.background,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            );
          }

          return onboardingViewModel.isOnboardingComplete
              ? const BookListPage()
              : const OnboardingPage();
        },
      ),

      routes: {
        '/onboarding': (_) => const OnboardingPage(),
        '/login': (_) =>  LoginPage(),
        '/register': (_) =>  RegisterPage(),
        '/home': (_) => const BookListPage(),
        '/add-book': (_) => const AddBookPage(),
        '/history': (_) => const HistoryPage(),
        '/profile': (_) => const ProfilePage(),
        '/settings': (_) => const SettingsPage(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}