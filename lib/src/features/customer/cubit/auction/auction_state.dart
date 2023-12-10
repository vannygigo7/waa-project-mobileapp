import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuctionState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuctionInitial extends AuctionState {}

class AuctionLoading extends AuctionState {}

class AuctionLoaded extends AuctionState {
  final List<ProductModel> products;

  AuctionLoaded({required this.products});
  @override
  List<Object> get props => [];
}

class AuctionError extends AuctionState {
  AuctionError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class AuctionDetail extends AuctionState {
  AuctionDetail({required this.product});
  final ProductModel product;

  @override
  List<Object> get props => [product];
}
