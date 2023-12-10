import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/network/dto/network_response_model.dart';
import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/customer/data/datasource/customer_datasource.dart';
import 'package:auction_app/src/features/customer/data/mapper/auction_mapper.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class CustomerRemoteDataSource implements CustomerDataSource {
  CustomerRemoteDataSource();
  final networkAPI = NetworkAPI(endpoint: EndpointConstant.customerProduct);

  @override
  Future<List<ProductModel>> getAll() async {
    try {
      final result = await networkAPI.getAll();
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
      networkAPI.endpoint = "${EndpointConstant.customerProduct}/$productId";
      final reqBody = {"bidAmount": bidAmount};
      final result = await networkAPI.add(jsonEncode(reqBody));
      networkAPI.endpoint = EndpointConstant.customerProduct;
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
