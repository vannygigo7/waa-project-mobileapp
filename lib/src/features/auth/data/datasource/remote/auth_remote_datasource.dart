import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/services/network/dto/network_response_model.dart';
import 'package:auction_app/core/services/network/network_service.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:auction_app/src/features/auth/data/mapper/auth_mapper.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

class AuthRemoteDataSource implements AuthDataSource {
  final NetworkService networkService;

  AuthRemoteDataSource({required this.networkService});

  @override
  Future<UserAccountModel> login(data) async {
    try {
      networkService.endpoint = EndpointConstant.login;
      var reqBody = data.toJson();
      // reqBody = {'email': 'c10@test.com', 'password': '123'};
      var res = await networkService.post(jsonEncode(reqBody));
      AppUtil.debugPrint(res.body);

      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(res.body));
      if (res.statusCode == 200) {
        return AuthMapper.jsonToUserAccountModel(responseModel.data);
      }
      throw ServerException(
          statusCode: responseModel.statusCode,
          message: "Email or password is incorrect.");
      // throw ServerException(
      //     statusCode: responseModel.statusCode, message: responseModel.message);
    } catch (e) {
      AppUtil.debugPrint("rethrow $e");
      rethrow;
    }
  }

  @override
  Future<void> register(data) async {
    try {
      networkService.endpoint = EndpointConstant.register;
      var reqBody = data.toJson();
      // reqBody = {
      //   "email": "customer10@test.com",
      //   "password": "123",
      //   "role": "USER",
      //   "firstName": "Customer",
      //   "lastName": "10",
      //   "profileImageUrl":
      //       "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png"
      // };
      var res = await networkService.post(jsonEncode(reqBody));
      AppUtil.debugPrint(res.body);
      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(res.body));
      if (res.statusCode == 200) {
        AppUtil.debugPrint(responseModel.message);
        return;
      }
      throw ServerException(
          message: responseModel.message, statusCode: responseModel.statusCode);
    } catch (e) {
      AppUtil.debugPrint("rethrow $e");
      rethrow;
    }
  }
}
