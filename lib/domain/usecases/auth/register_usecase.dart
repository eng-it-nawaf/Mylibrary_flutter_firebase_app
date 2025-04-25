// import 'package:onboarding_app/domain/repositories/auth_repository.dart';
//
// class RegisterUseCase {
//   final AuthRepository repository;
//
//   RegisterUseCase(this.repository);
//
//   Future<bool> execute(String email, String password) async {
//     return await repository.register(email, password);
//   }
// }

import '../../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> execute(String email, String password) {
    return repository.register(email, password);
  }
}