import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/services/network/dto/network_response_model.dart';
import 'package:auction_app/core/services/network/network_api.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/customer/data/datasource/customer_datasource.dart';
import 'package:auction_app/src/features/customer/data/mapper/auction_mapper.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class CustomerRemoteDataSource implements CustomerDataSource {
  CustomerRemoteDataSource({required this.networkService});
  final NetworkService networkService;

  @override
  Future<List<ProductModel>> getAll() async {
    try {
      final result = await networkService.getAll();
      NetworkResponseModel responseModel =
          NetworkResponseModel.fromJson(jsonDecode(result.body));
      if (result.statusCode == 200) {
        return AuctionMapper.jsonToProductModelList(responseModel.data);
      }
      throw ServerException(
          message: responseModel.message, statusCode: responseModel.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> addBid(int productId, double bidAmount) async {
    try {
      networkService.endpoint =
          "${EndpointConstant.customerProduct}/$productId";
      final reqBody = {"bidAmount": bidAmount};
      final result = await networkService.post(jsonEncode(reqBody));
      networkService.endpoint = EndpointConstant.customerProduct;
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
