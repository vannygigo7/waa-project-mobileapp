import 'dart:convert';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/network/dto/network_response_model.dart';
import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/mapper/auction_mapper.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionRemoteDataSource implements AuctionDataSource {
  AuctionRemoteDataSource({required this.networkAPI});
  final NetworkAPI networkAPI;

  @override
  Future<List<ProductModel>> getAll() async {
    try {
      final result = await networkAPI.getAll();
      if (result.statusCode == 200) {
        NetworkResponseModel response =
            NetworkResponseModel.fromJson(jsonDecode(result.body));
        return AuctionMapper.jsonToProductModelList(response.data);
      }
      return [];
    } catch (e) {
      throw ServerException();
    }
  }
}
