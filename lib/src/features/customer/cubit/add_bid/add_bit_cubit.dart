import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_state.dart';
import 'package:auction_app/src/features/customer/data/repository/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBidCubit extends Cubit<AddBidState> {
  AddBidCubit({required this.customerRepository}) : super(const AddBidState());
  final CustomerRepository customerRepository;

  add(int productId, double bidAmount) async {
    if (AppUtil.checkIsNull(bidAmount)) {
      emit(AddBidState(
          status: AddBidStatus.error,
          product: state.product,
          message: "Please enter bid amount"));
      return;
    }
    emit(const AddBidState(status: AddBidStatus.loading));
    final result = await customerRepository.addBid(productId, bidAmount);
    result.fold(
      (l) => emit(AddBidState(
          status: AddBidStatus.error,
          product: state.product,
          message: l.message)),
      (r) => emit(AddBidState(
          status: AddBidStatus.success,
          product: r,
          message: "Successfully bidded")),
    );
  }
}
