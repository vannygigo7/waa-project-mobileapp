import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionMapper {
  static List<ProductModel> jsonToProductModelList(List data) {
    try {
      return data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static ProductModel jsonToProductModel(Map<String, dynamic> data) {
    try {
      return ProductModel.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
