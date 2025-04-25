// import 'package:onboarding_app/domain/repositories/auth_repository.dart';
//
// class LoginUseCase {
//   final AuthRepository repository;
//
//   LoginUseCase(this.repository);
//
//   Future<bool> execute(String email, String password) async {
//     return await repository.login(email, password);
//   }
// }

import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(String email, String password) {
    return repository.login(email, password);
  }
}