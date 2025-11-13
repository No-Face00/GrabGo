
import '../../core/network/api_client.dart';
import '../../domain/models/user_profile.dart';

class UserRemoteDataSource {
  UserRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  Future<UserProfile> readProfile({required String token}) async {
    final json =
    await apiClient.get('/api/ReadProfile', headers: {'token': token})
    as Map<String, dynamic>;

    final data = json['data'] as Map<String, dynamic>;
    return UserProfile.fromJson(data);
  }
}
