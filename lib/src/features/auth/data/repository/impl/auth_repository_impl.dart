import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<UserAccountModel> login(data) async {
    try {
      return await authDataSource.login(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(data) async {
    try {
      return await authDataSource.register(data);
    } catch (e) {
      AppUtil.debugPrint(e.toString());
    }
  }
}
