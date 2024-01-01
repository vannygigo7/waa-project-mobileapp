import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:dartz/dartz.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  AuctionRepositoryImpl({required this.auctionDataSource});
  final AuctionDataSource auctionDataSource;

  @override
  ResultFuture<List<ProductModel>> getAll({String? params}) async {
    try {
      final res = await auctionDataSource.getAll(params: params);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed to load data.", statusCode: 400));
    }
  }

  @override
  ResultFuture<ProductModel> getById(int productId) async {
    try {
      final res = await auctionDataSource.getById(productId);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed to load data.", statusCode: 400));
    }
  }
}
