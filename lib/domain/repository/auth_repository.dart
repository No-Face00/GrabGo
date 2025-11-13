abstract class AuthRepository {
  Future<void> requestLoginOtp({required String email});

  Future<String> verifyLogin({required String email, required String otp});
}
