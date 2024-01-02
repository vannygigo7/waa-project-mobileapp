import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/src/features/auth/cubit/login_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/login_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data/user_account.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepository authRepository;
  late UserAccountModel userAccountModel;

  setUp(() {
    authRepository = MockAuthRepository();
    userAccountModel = UserAccountModel.fromJson(userAccountDummy);
  });

  group('Login Tests', () {
    test('Login Cubit init state', () {
      final loginCubit = LoginCubit(authRepository: authRepository);
      expect(loginCubit.state, const LoginState());
    });

    blocTest(
      'emit loading and failure and required email and password',
      setUp: () {
        when(() => authRepository.login(
                const LoginRequestModel(email: 'email', password: 'password')))
            .thenAnswer(
          (_) => Future.value(Right(userAccountModel)),
        );
      },
      build: () => LoginCubit(authRepository: authRepository),
      act: (bloc) async {
        await bloc.login('', 'password');
        await bloc.login('email', '');
      },
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        const LoginState(
            status: LoginStatus.failure,
            message: 'Please enter email and password'),
        const LoginState(status: LoginStatus.loading),
        const LoginState(
            status: LoginStatus.failure,
            message: 'Please enter email and password'),
      ],
    );

    blocTest(
      'emit loading and success',
      setUp: () {
        when(() => authRepository.login(
                const LoginRequestModel(email: 'email', password: 'password')))
            .thenAnswer(
          (_) => Future.value(Right(userAccountModel)),
        );
      },
      build: () => LoginCubit(authRepository: authRepository),
      act: (bloc) async {
        await bloc.login('email', 'password');
      },
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        LoginState(
            status: LoginStatus.success,
            message: 'Successfully login',
            userAccount: userAccountModel)
      ],
    );

    blocTest(
      'emit loading and failure',
      setUp: () {
        when(() => authRepository.login(
                const LoginRequestModel(email: 'email', password: 'password')))
            .thenAnswer(
          (_) => Future.value(const Left(ServerFailure(
              message: 'Email or password is incorrect.', statusCode: 400))),
        );
      },
      build: () => LoginCubit(authRepository: authRepository),
      act: (bloc) async {
        await bloc.login('email', 'password');
      },
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        const LoginState(
            status: LoginStatus.failure,
            message: 'Email or password is incorrect.')
      ],
    );
  });
}
