
import '../../core/network/api_client.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  Future<void> requestLoginOtp({required String email}) async {
    await apiClient.get('/api/UserLogin/$email');
  }

  Future<String> verifyLogin({
    required String email,
    required String otp,
  }) async {
    final json =
    await apiClient.get('/api/VerifyLogin/$email/$otp')
    as Map<String, dynamic>;
    final token = (json['data'] ?? '') as String;
    return token;
  }
}
