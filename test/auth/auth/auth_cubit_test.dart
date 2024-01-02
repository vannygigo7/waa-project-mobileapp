import 'package:auction_app/src/features/auth/cubit/auth_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../login/login_cubit_test.dart';

class MockAuctionRepository extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('Auth Cubit Tests', () {
    test('unknown state', () {
      when(
        () => authRepository.status,
      ).thenAnswer((_) => const Stream.empty());
      final authCubit = AuthCubit(authRepository: authRepository);
      expect(authCubit.state, const AuthState());
      authCubit.close();
    });

    blocTest(
      'emit authenticated state when status is authenticated',
      build: () => AuthCubit(authRepository: authRepository),
      setUp: () {
        when(() => authRepository.status)
            .thenAnswer((_) => Stream.value(AuthStatus.authenticated));
      },
      expect: () => [const AuthState(status: AuthStatus.authenticated)],
    );

    blocTest(
      'emit unAuthenticated state when status is unAuthenticated',
      build: () => AuthCubit(authRepository: authRepository),
      setUp: () {
        when(() => authRepository.status)
            .thenAnswer((_) => Stream.value(AuthStatus.unAuthenticated));
      },
      expect: () => [const AuthState(status: AuthStatus.unAuthenticated)],
    );

    blocTest(
      'call logout on authRepository',
      build: () => AuthCubit(authRepository: authRepository),
      setUp: () {
        when(() => authRepository.status)
            .thenAnswer((_) => const Stream.empty());
        when(() => authRepository.logOut())
            .thenAnswer((_) => Future.value(const Right(null)));
      },
      act: (bloc) async {
        await bloc.logOut();
      },
      expect: () => [],
      verify: (_) {
        verify(() => authRepository.logOut()).called(1);
      },
    );

    test('on logout', () async {
      when(() => authRepository.status).thenAnswer((_) => const Stream.empty());
      when(() => authRepository.logOut())
          .thenAnswer((_) => Future.value(const Right(null)));
      final authCubit = AuthCubit(authRepository: authRepository);
      await authCubit.logOut();
      expect(authCubit.state, const AuthState());
      authCubit.close();
    });
  });
}
