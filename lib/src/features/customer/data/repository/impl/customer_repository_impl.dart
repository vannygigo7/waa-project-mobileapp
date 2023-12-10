import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/customer/data/datasource/customer_datasource.dart';
import 'package:auction_app/src/features/customer/data/repository/customer_repository.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:dartz/dartz.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl({required this.customerDataSource});
  final CustomerDataSource customerDataSource;

  @override
  ResultFuture<List<ProductModel>> getAll() async {
    try {
      final res = await customerDataSource.getAll();
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
  ResultFuture<ProductModel> addBid(int productId, double bidAmount) async {
    try {
      final res = await customerDataSource.addBid(productId, bidAmount);
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
