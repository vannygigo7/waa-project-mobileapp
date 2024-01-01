import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

abstract class AuctionRepository {
  ResultFuture<List<ProductModel>> getAll({String? params});
  ResultFuture<ProductModel> getById(int productId);
}
