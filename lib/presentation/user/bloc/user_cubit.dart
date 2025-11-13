import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabgo/presentation/user/bloc/user_state.dart';

import '../../../core/storage/token_storage.dart';
import '../../../domain/models/user_profile.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.authRepository,
    required this.userRepository,
    required this.tokenStorage,
  }) : super(const UserState(status: UserStatus.unknown));

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final TokenStorage tokenStorage;

  Future<void> initialize() async {
    final token = await tokenStorage.readToken();
    if (token == null || token.isEmpty) {
      emit(const UserState(status: UserStatus.unauthenticated));
      return;
    }
    emit(UserState(status: UserStatus.authenticated, token: token));
    await loadProfile();
  }

  Future<void> requestOtp(String email) async {
    try {
      await authRepository.requestLoginOtp(email: email);
      emit(UserState(status: UserStatus.otpSent, email: email));
    } catch (e) {
      emit(UserState(status: UserStatus.error, message: e.toString()));
    }
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      emit(state.copyWith(status: UserStatus.authenticating));
      final token = await authRepository.verifyLogin(email: email, otp: otp);
      await tokenStorage.saveToken(token);
      emit(UserState(status: UserStatus.authenticated, token: token));
      await loadProfile();
    } catch (e) {
      emit(UserState(status: UserStatus.error, message: e.toString()));
    }
  }

  Future<void> loadProfile() async {
    final token = state.token;
    if (token == null || token.isEmpty) return;
    try {
      final UserProfile profile = await userRepository.fetchProfile(
        token: token,
      );
      emit(state.copyWith(profile: profile, status: UserStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error, message: e.toString()));
    }
  }

  Future<void> logout() async {
    await tokenStorage.clearToken();
    emit(const UserState(status: UserStatus.unauthenticated));
  }
}
