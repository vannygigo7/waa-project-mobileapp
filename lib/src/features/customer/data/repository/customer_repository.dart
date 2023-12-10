import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

abstract class CustomerRepository {
  ResultFuture<List<ProductModel>> getAll();
  ResultFuture<ProductModel> addBid(int productId, double bidAmount);
}
