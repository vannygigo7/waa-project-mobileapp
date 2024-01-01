import 'package:auction_app/src/features/auth/model/user_account_model.dart';
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String message;
  final UserAccountModel? userAccount;
  const RegisterState(
      {this.status = RegisterStatus.initial,
      this.message = '',
      this.userAccount});

  RegisterState copyWith(
      {RegisterStatus? status,
      String? message,
      UserAccountModel? userAccount}) {
    return RegisterState(
        status: status ?? this.status,
        message: message ?? this.message,
        userAccount: userAccount ?? this.userAccount);
  }

  @override
  List<Object?> get props => [status, message, userAccount];
}
