import 'package:auction_app/src/features/customer/model/product_model.dart';

abstract class AuctionDataSource {
  Future<List<ProductModel>> getAll();
  Future<ProductModel> getById(int productId);
}
