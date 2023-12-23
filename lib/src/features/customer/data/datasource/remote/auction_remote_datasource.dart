import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/network/dto/network_response_model.dart';
import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/mapper/auction_mapper.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionRemoteDataSource implements AuctionDataSource {
  AuctionRemoteDataSource();
  final networkAPI = NetworkAPI(endpoint: EndpointConstant.home);

  @override
  Future<List<ProductModel>> getAll() async {
    try {
      AppUtil.debugPrint("AuctionRemoteDataSource: getAll");
      final result = await networkAPI.getAll();
      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(result.body));
      if (result.statusCode == 200) {
        return AuctionMapper.jsonToProductModelList(responseModel.data);
      }
      throw ServerException(
          statusCode: responseModel.statusCode, message: responseModel.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getById(int productId) async {
    try {
      final result = await networkAPI.getById(productId);
      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(result.body));
      if (result.statusCode == 200) {
        return AuctionMapper.jsonToProductModel(responseModel.data);
      }
      throw ServerException(
          message: responseModel.message, statusCode: responseModel.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
