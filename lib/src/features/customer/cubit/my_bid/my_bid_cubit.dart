import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_state.dart';
import 'package:auction_app/src/features/customer/data/repository/customer_repository.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBidCubit extends Cubit<MyBidState> {
  MyBidCubit({required this.customerRepository}) : super(const MyBidState());
  List<ProductModel> allProducts = [];

  final CustomerRepository customerRepository;

  getAllMyBids() async {
    emit(state.copyWith(status: MyBidStatus.loading));
    final res = await customerRepository.getAll();
    res.fold(
      (l) => emit(state.copyWith(status: MyBidStatus.error)),
      (r) {
        allProducts = r;
        emit(state.copyWith(status: MyBidStatus.success, products: r));
      },
    );
  }

  getMyBidsByTitle({String? title}) async {
    emit(state.copyWith(status: MyBidStatus.loading));
    if (title == null || title.isEmpty) {
      emit(state.copyWith(status: MyBidStatus.success, products: allProducts));
      return;
    }
    var filteredProducts = allProducts
        .where((p) => p.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    emit(state.copyWith(
        status: MyBidStatus.success, products: filteredProducts));
  }
}
