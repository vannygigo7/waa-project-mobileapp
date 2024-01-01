import 'dart:async';

import 'package:auction_app/core/errors/exception.dart';
import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/core/utils/typedef.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final _streamController = StreamController<AuthStatus>();

  @override
  Stream<AuthStatus> get status => _streamController.stream;

  AuthRepositoryImpl({required this.authDataSource});
  @override
  ResultFuture<UserAccountModel> login(data) async {
    try {
      final res = await authDataSource.login(data);
      _streamController.add(AuthStatus.authenticated);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Login failed", statusCode: 400));
    }
  }

  @override
  ResultFuture<void> register(data) async {
    try {
      final res = await authDataSource.register(data);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException {
      return const Left(
          CacheFailure(message: "Registration failed", statusCode: 400));
    } catch (e) {
      AppUtil.debugPrint("General Ex: $e");
      return const Left(
          GeneralFailure(message: "Registration failed.", statusCode: 400));
    }
  }

  @override
  ResultFuture<void> logOut() async {
    _streamController.add(AuthStatus.unAuthenticated);
    return const Right(null);
  }

  @override
  void dispose() => _streamController.close();
}
