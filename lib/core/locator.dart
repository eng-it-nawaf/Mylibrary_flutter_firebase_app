import 'package:get_it/get_it.dart';
import 'package:maktabati_app/core/services/shared_prefs_service.dart';
import 'package:maktabati_app/data/datasources/local/book_local_datasource.dart';
import 'package:maktabati_app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:maktabati_app/data/repositories/auth_repository_impl.dart';
import 'package:maktabati_app/data/repositories/book_repository_impl.dart';
import 'package:maktabati_app/domain/repositories/auth_repository.dart';
import 'package:maktabati_app/domain/repositories/book_repository.dart';
import 'package:maktabati_app/domain/usecases/auth/login_usecase.dart';
import 'package:maktabati_app/domain/usecases/auth/register_usecase.dart';
import 'package:maktabati_app/domain/usecases/book/add_book_usecase.dart';
import 'package:maktabati_app/domain/usecases/book/get_books_usecase.dart';
import 'package:maktabati_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:maktabati_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:maktabati_app/presentation/viewmodels/onboarding_viewmodel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Services
  getIt.registerSingleton<SharedPrefsService>(SharedPrefsService());

  // Data Sources
  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource());
  getIt.registerSingleton<BookLocalDataSource>(BookLocalDataSource());

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerSingleton<BookRepository>(
    BookRepositoryImpl(getIt<BookLocalDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<GetBooksUseCase>(
    GetBooksUseCase(getIt<BookRepository>()),
  );
  getIt.registerSingleton<AddBookUseCase>(
    AddBookUseCase(getIt<BookRepository>()),
  );

  // ViewModels
  getIt.registerFactory<AuthViewModel>(
        () => AuthViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
  getIt.registerFactory<BookViewModel>(
        () => BookViewModel(
      getBooksUseCase: getIt<GetBooksUseCase>(),
      addBookUseCase: getIt<AddBookUseCase>(),
    ),
  );
  getIt.registerFactory<OnboardingViewModel>(
        () => OnboardingViewModel(getIt<SharedPrefsService>()),
  );
}