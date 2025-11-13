import 'package:equatable/equatable.dart';

import '../../../domain/models/user_profile.dart';


enum UserStatus {
  unknown,
  unauthenticated,
  otpSent,
  authenticating,
  authenticated,
  error,
}

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.unknown,
    this.email,
    this.token,
    this.profile,
    this.message,
  });

  final UserStatus status;
  final String? email;
  final String? token;
  final UserProfile? profile;
  final String? message;

  UserState copyWith({
    UserStatus? status,
    String? email,
    String? token,
    UserProfile? profile,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      email: email ?? this.email,
      token: token ?? this.token,
      profile: profile ?? this.profile,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, email, token, profile, message];
}
