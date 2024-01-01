import 'package:auction_app/core/errors/failure.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_state.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data/product.dart';

class MockAuctionRepository extends Mock implements AuctionRepository {}

void main() {
  late AuctionRepository auctionRepository;
  late ProductModel productModel;

  setUp(() {
    auctionRepository = MockAuctionRepository();
    productModel = ProductModel.fromJson(productDummy);
  });

  group('Auction Cubit', () {
    test('Auction init state', () {
      final auctionCubit = AuctionCubit(auctionRepository: auctionRepository);
      expect(auctionCubit.state, AuctionInitial());
    });

    blocTest<AuctionCubit, AuctionState>(
      'getAll: emit loading and success',
      setUp: () {
        when(() => auctionRepository.getAll())
            .thenAnswer((_) => Future.value(const Right([])));
      },
      build: () => AuctionCubit(auctionRepository: auctionRepository),
      act: (bloc) async {
        await bloc.getAll();
      },
      expect: () => [AuctionLoading(), AuctionLoaded(products: const [])],
    );

    blocTest<AuctionCubit, AuctionState>(
      'getAll: emit loading and failure',
      setUp: () {
        when(() => auctionRepository.getAll()).thenAnswer((_) => Future.value(
            const Left(ServerFailure(message: '', statusCode: 0))));
      },
      build: () => AuctionCubit(auctionRepository: auctionRepository),
      act: (bloc) async {
        await bloc.getAll();
      },
      expect: () => [AuctionLoading(), AuctionError(errorMessage: '')],
    );

    blocTest<AuctionCubit, AuctionState>(
      'getById: emit loading and success',
      setUp: () {
        when(() => auctionRepository.getById(any()))
            .thenAnswer((_) => Future.value(Right(productModel)));
      },
      build: () => AuctionCubit(auctionRepository: auctionRepository),
      act: (bloc) async {
        await bloc.getById(2);
      },
      expect: () => [AuctionLoading(), AuctionDetail(product: productModel)],
    );
  });
}
