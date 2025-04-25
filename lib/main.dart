import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maktabati_app/presentation/pages/auth/login_page.dart';
import 'package:provider/provider.dart';
import 'package:maktabati_app/core/services/shared_prefs_service.dart';
import 'package:maktabati_app/data/datasources/local/book_local_datasource.dart';
import 'package:maktabati_app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:maktabati_app/data/repositories/auth_repository_impl.dart';
import 'package:maktabati_app/data/repositories/book_repository_impl.dart';
import 'package:maktabati_app/domain/usecases/auth/login_usecase.dart';
import 'package:maktabati_app/domain/usecases/auth/register_usecase.dart';
import 'package:maktabati_app/domain/usecases/book/add_book_usecase.dart';
import 'package:maktabati_app/domain/usecases/book/get_books_usecase.dart';
import 'package:maktabati_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:maktabati_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:maktabati_app/presentation/viewmodels/onboarding_viewmodel.dart';
import 'package:maktabati_app/presentation/pages/onboarding/onboarding_page.dart';
import 'package:maktabati_app/presentation/pages/book/book_list_page.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize services
  final sharedPrefs = SharedPrefsService();
  await sharedPrefs.init();

  // Initialize data sources
  final authRemoteDataSource = AuthRemoteDataSource();
  final bookLocalDataSource = BookLocalDataSource();

  // Initialize repositories
  final authRepo = AuthRepositoryImpl(authRemoteDataSource);
  final bookRepo = BookRepositoryImpl(bookLocalDataSource);

  // Initialize use cases
  final loginUseCase = LoginUseCase(authRepo);
  final registerUseCase = RegisterUseCase(authRepo);
  final getBooksUseCase = GetBooksUseCase(bookRepo);
  final addBookUseCase = AddBookUseCase(bookRepo);

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
      title: 'Maktabaty App',
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (_) => const OnboardingPage(),
        '/login': (_) =>  LoginPage(),
        '/home': (_) => const BookListPage(),
        // '/settings': (context) => SettingsScreen(),
        // '/profile': (context) => ProfileScreen(),
        // '/history': (context) => HistoryScreen(),
      },
    );
  }
}

