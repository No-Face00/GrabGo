

import '../../domain/models/user_profile.dart';
import '../../domain/repository/user_repository.dart';
import '../remote_data_source/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.remoteDataSource});

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<UserProfile> fetchProfile({required String token}) {
    return remoteDataSource.readProfile(token: token);
  }
}
