import '../../domain/repository/auth_repository.dart';
import '../remote_data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<void> requestLoginOtp({required String email}) {
    return remoteDataSource.requestLoginOtp(email: email);
  }

  @override
  Future<String> verifyLogin({required String email, required String otp}) {
    return remoteDataSource.verifyLogin(email: email, otp: otp);
  }
}
