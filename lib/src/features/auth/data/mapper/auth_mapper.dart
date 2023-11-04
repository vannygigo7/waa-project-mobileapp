import 'package:auction_app/src/features/auth/model/user_account_model.dart';

class AuthMapper {
  static UserAccountModel jsonToUserAccountModel(Map<String, dynamic> json) {
    return UserAccountModel.fromJson(json);
  }
}
