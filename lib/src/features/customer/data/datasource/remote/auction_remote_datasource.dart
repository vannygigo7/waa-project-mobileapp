import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/services/network/dto/network_response_model.dart';
import 'package:auction_app/core/services/network/network_service.dart';
import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/mapper/auction_mapper.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionRemoteDataSource implements AuctionDataSource {
  AuctionRemoteDataSource({required this.networkService});
  final NetworkService networkService;

  @override
  Future<List<ProductModel>> getAll({String? params}) async {
    try {
      final result = await networkService.getAll(params: params);
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
      final result = await networkService.getById(productId);
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
