import 'package:auction_app/src/features/customer/cubit/auction/auction_state.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit({required this.auctionRepository}) : super(AuctionInitial());
  final AuctionRepository auctionRepository;

  getAll({String? params}) async {
    emit(AuctionLoading());
    final result = await auctionRepository.getAll(params: params);
    result.fold(
      (l) => emit(AuctionError(errorMessage: l.errorMessage)),
      (r) => emit(AuctionLoaded(products: r)),
    );
  }

  getById(int productId) async {
    emit(AuctionLoading());
    final result = await auctionRepository.getById(productId);
    result.fold((l) => null, (r) => emit(AuctionDetail(product: r)));
  }
}
