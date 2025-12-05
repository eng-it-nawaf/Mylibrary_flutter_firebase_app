import 'package:onboarding_app/domain/repositories/auth_repository.dart';
import 'package:onboarding_app/data/datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<bool> register(String email, String password) async {
    return await remoteDataSource.register(email, password);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}