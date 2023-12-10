import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

abstract class AuthRepository {
  ResultFuture<UserAccountModel> login(LoginRequestModel data);
  ResultFuture<void> register(RegisterRequestModel data);
}
