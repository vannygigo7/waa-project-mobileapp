import 'package:equatable/equatable.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';

enum AddBidStatus { initial, loading, success, error }

class AddBidState extends Equatable {
  final AddBidStatus status;
  final ProductModel? product;
  final String message;
  const AddBidState({
    this.status = AddBidStatus.initial,
    this.product,
    this.message = '',
  });

  AddBidState copyWith({
    AddBidStatus? status,
    ProductModel? product,
    String? message,
  }) {
    return AddBidState(
      status: status ?? this.status,
      product: product ?? this.product,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, product, message];
}
