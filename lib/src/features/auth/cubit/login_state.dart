import 'package:auction_app/src/features/auth/model/user_account_model.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String message;
  final UserAccountModel? userAccount;
  const LoginState(
      {this.status = LoginStatus.initial, this.message = '', this.userAccount});

  LoginState copyWith(
      {LoginStatus? status, String? message, UserAccountModel? userAccount}) {
    return LoginState(
        status: status ?? this.status,
        message: message ?? this.message,
        userAccount: userAccount ?? this.userAccount);
  }

  @override
  List<Object?> get props => [status, message, userAccount];
}
