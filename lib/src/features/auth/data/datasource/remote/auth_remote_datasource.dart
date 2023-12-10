import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/network/dto/network_response_model.dart';
import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:auction_app/src/features/auth/data/mapper/auth_mapper.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

class AuthRemoteDataSource implements AuthDataSource {
  final NetworkAPI networkAPI;

  AuthRemoteDataSource({required this.networkAPI});

  @override
  Future<UserAccountModel> login(data) async {
    try {
      networkAPI.endpoint = EndpointConstant.login;
      var reqBody = data.toJson();
      reqBody = {'email': 'c2@test.com', 'password': '123'};
      var res = await networkAPI.add(jsonEncode(reqBody));
      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(res.body));
      AppUtil.debugPrint(res.body);
      if (res.statusCode == 200) {
        return AuthMapper.jsonToUserAccountModel(responseModel.data);
      }
      throw ServerException(
          statusCode: responseModel.statusCode, message: responseModel.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(data) async {
    AppUtil.debugPrint("register");
    try {
      networkAPI.endpoint = EndpointConstant.register;
      var reqBody = data.toJson();
      reqBody = {
        "email": "customer10@test.com",
        "password": "123",
        "role": "USER",
        "firstName": "Customer",
        "lastName": "10",
        "profileImageUrl":
            "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png"
      };
      var res = await networkAPI.add(jsonEncode(reqBody));
      AppUtil.debugPrint(res.body);
      if (res.statusCode == 200) {
        NetworkResponseModel responseModel =
            NetworkResponseModel.fromJson(jsonDecode(res.body));
        AppUtil.debugPrint(responseModel.data);
      }
      throw ServerException();
    } catch (e) {
      throw Exception();
    }
  }
}
