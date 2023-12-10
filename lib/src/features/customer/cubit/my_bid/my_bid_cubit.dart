import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_state.dart';
import 'package:auction_app/src/features/customer/data/repository/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBidCubit extends Cubit<MyBidState> {
  MyBidCubit({required this.customerRepository}) : super(const MyBidState());

  final CustomerRepository customerRepository;

  getAllMyBids() async {
    emit(state.copyWith(status: MyBidStatus.loading));
    final res = await customerRepository.getAll();
    res.fold(
      (l) => emit(state.copyWith(status: MyBidStatus.error)),
      (r) => emit(state.copyWith(status: MyBidStatus.success, products: r)),
    );
  }
}
