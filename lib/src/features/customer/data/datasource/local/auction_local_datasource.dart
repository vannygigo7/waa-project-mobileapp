import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionLocalDataSource implements AuctionDataSource {
  @override
  Future<List<ProductModel>> getAll() {
    throw UnimplementedError();
  }
}
