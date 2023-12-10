import 'package:equatable/equatable.dart';

import 'package:auction_app/src/features/customer/model/product_model.dart';

enum MyBidStatus { initial, loading, success, error }

class MyBidState extends Equatable {
  final MyBidStatus status;
  final List<ProductModel> products;
  final String errorMessage;

  const MyBidState(
      {this.status = MyBidStatus.initial,
      this.products = const [],
      this.errorMessage = ''});

  @override
  List<Object?> get props => [status, products, errorMessage];

  MyBidState copyWith({
    MyBidStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return MyBidState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
