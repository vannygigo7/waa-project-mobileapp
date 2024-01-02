import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/src/features/auth/cubit/register_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/register_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  setUp(() {
    authRepository = MockAuthRepository();
    registerFallbackValue(
      const RegisterRequestModel(
        email: 'email',
        password: 'password',
        role: 'role',
        firstName: 'firstName',
        lastName: 'lastName',
      ),
    );
  });

  group('Register Tests', () {
    test('Register init state', () {
      final registerCubit = RegisterCubit(authRepository: authRepository);
      expect(registerCubit.state,
          const RegisterState(status: RegisterStatus.initial));
    });

    blocTest(
      'emit loading and success',
      setUp: () {
        when(
          () => authRepository.register(any()),
        ).thenAnswer(
          (_) => Future.value(const Right(null)),
        );
      },
      build: () => RegisterCubit(authRepository: authRepository),
      act: (bloc) async {
        await bloc.register('firstName', 'lastName', 'email', '123', '123');
      },
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.success, message: 'Successfully registered'),
      ],
    );

    blocTest(
      'emit loading and failure',
      setUp: () {
        when(
          () => authRepository.register(any()),
        ).thenAnswer(
          (_) => Future.value(const Left(
              ServerFailure(message: 'Failed to register', statusCode: 0))),
        );
      },
      build: () => RegisterCubit(authRepository: authRepository),
      act: (bloc) async {
        await bloc.register('firstName', 'lastName', 'email', '123', '123');
      },
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure, message: 'Failed to register'),
      ],
    );

    blocTest(
      'emit loading and failure with validation',
      build: () => RegisterCubit(authRepository: authRepository),
      setUp: () {
        when(
          () => authRepository.register(any()),
        ).thenAnswer(
          (_) => Future.value(const Left(
              ServerFailure(message: 'Failed to register', statusCode: 0))),
        );
      },
      act: (bloc) async {
        await bloc.register('', 'lastName', 'email', 'password', 'conPassword');
        await bloc.register(
            'firstName', '', 'email', 'password', 'conPassword');
        await bloc.register(
            'firstName', 'lastName', '', 'password', 'conPassword');
        await bloc.register(
            'firstName', 'lastName', 'email', '', 'conPassword');
        await bloc.register('firstName', 'lastName', 'email', 'password', '');
        await bloc.register('firstName', 'lastName', 'email', '12', '123');
      },
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Please fill all required fields*'),
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Please fill all required fields*'),
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Please fill all required fields*'),
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Please fill all required fields*'),
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Please fill all required fields*'),
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
            status: RegisterStatus.failure,
            message: 'Password and Confirm password don\'t match'),
      ],
    );
  });
}
