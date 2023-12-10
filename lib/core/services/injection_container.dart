import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:auction_app/src/features/customer/data/datasource/auction_datasource.dart';
import 'package:auction_app/src/features/customer/data/datasource/customer_datasource.dart';
import 'package:auction_app/src/features/customer/data/datasource/remote/auction_remote_datasource.dart';
import 'package:auction_app/src/features/customer/data/datasource/remote/customer_remote_datasource.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:auction_app/src/features/customer/data/repository/customer_repository.dart';
import 'package:auction_app/src/features/customer/data/repository/impl/auction_repository_impl.dart';
import 'package:auction_app/src/features/customer/data/repository/impl/customer_repository_impl.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future initLocator() async {
  locator
    ..registerFactory(() => AuctionCubit(auctionRepository: locator()))
    ..registerLazySingleton<AuctionRepository>(
        () => AuctionRepositoryImpl(auctionDataSource: locator()))
    ..registerLazySingleton<AuctionDataSource>(() => AuctionRemoteDataSource());

  locator
    ..registerFactory(() => MyBidCubit(customerRepository: locator()))
    ..registerLazySingleton<CustomerRepository>(
        () => CustomerRepositoryImpl(customerDataSource: locator()))
    ..registerLazySingleton<CustomerDataSource>(
        () => CustomerRemoteDataSource());

  locator.registerFactory(() => AddBidCubit(customerRepository: locator()));
}
