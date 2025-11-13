import '../models/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> fetchProfile({required String token});
}
