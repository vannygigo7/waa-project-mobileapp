import 'package:auction_app/src/features/customer/model/product_model.dart';

abstract class CustomerDataSource {
  Future<List<ProductModel>> getAll();
  Future<ProductModel> addBid(int productId, double bidAmount);
}
