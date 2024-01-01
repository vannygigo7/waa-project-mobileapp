import 'package:auction_app/core/services/network/network_api.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/auth/cubit/auth_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/login_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/register_cubit.dart';
import 'package:auction_app/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:auction_app/src/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/data/repository/impl/auth_repository_impl.dart';
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
    ..registerLazySingleton(() => AuctionCubit(auctionRepository: locator()))
    ..registerLazySingleton<AuctionRepository>(
        () => AuctionRepositoryImpl(auctionDataSource: locator()))
    ..registerLazySingleton<AuctionDataSource>(() => AuctionRemoteDataSource(
        networkService: NetworkService(endpoint: EndpointConstant.home)));

  locator
    ..registerLazySingleton(() => MyBidCubit(customerRepository: locator()))
    ..registerLazySingleton<CustomerRepository>(
        () => CustomerRepositoryImpl(customerDataSource: locator()))
    ..registerLazySingleton<CustomerDataSource>(() => CustomerRemoteDataSource(
        networkService:
            NetworkService(endpoint: EndpointConstant.customerProduct)));

  locator
      .registerLazySingleton(() => AddBidCubit(customerRepository: locator()));

  locator
    ..registerLazySingleton(() => AuthCubit(authRepository: locator()))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(authDataSource: locator()))
    ..registerLazySingleton<AuthDataSource>(() =>
        AuthRemoteDataSource(networkService: NetworkService(endpoint: '')));

  locator.registerLazySingleton(() => LoginCubit(authRepository: locator()));
  locator.registerLazySingleton(() => RegisterCubit(authRepository: locator()));
}
