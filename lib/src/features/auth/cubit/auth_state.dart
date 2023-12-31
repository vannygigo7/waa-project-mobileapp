import 'package:equatable/equatable.dart';

import 'package:auction_app/src/features/auth/model/user_account_model.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unAuthenticated,
}

class AuthState extends Equatable {
  final UserAccountModel? userAccount;
  final AuthStatus status;
  final String message;

  const AuthState(
      {this.userAccount, this.status = AuthStatus.unknown, this.message = ''});

  @override
  List<Object?> get props => [userAccount, status, message];

  AuthState copyWith({
    UserAccountModel? userAccount,
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      userAccount: userAccount ?? this.userAccount,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
