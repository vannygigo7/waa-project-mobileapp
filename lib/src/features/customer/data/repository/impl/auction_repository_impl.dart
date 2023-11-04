import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  AuctionRepositoryImpl({required this.auctionDataSource});
  final AuctionDataSource auctionDataSource;

  @override
  Future<List<ProductModel>> getAll() async {
    try {
      return await auctionDataSource.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getBy(String title) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getByCustomerId(int customerId) {
    throw UnimplementedError();
  }
}
