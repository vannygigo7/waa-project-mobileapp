import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

abstract class AuthRepository {
  Future<UserAccountModel> login(LoginRequestModel data);
  Future<void> register(RegisterRequestModel data);
}
