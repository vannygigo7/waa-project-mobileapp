import 'package:auction_app/src/features/customer/model/product_model.dart';

abstract class AuctionRepository {
  Future<List<ProductModel>> getAll();
  Future<List<ProductModel>> getBy(String title);
  Future<List<ProductModel>> getByCustomerId(int customerId);
}
