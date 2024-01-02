import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuctionState extends Equatable {}

class AuctionInitial extends AuctionState {
  @override
  List<Object> get props => [];
}

class AuctionLoading extends AuctionState {
  @override
  List<Object> get props => [];
}

class AuctionLoaded extends AuctionState {
  final List<ProductModel> products;

  AuctionLoaded({required this.products});
  @override
  List<Object> get props => [];
}

class AuctionError extends AuctionState {
  AuctionError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class AuctionDetail extends AuctionState {
  AuctionDetail({required this.product});
  final ProductModel product;

  @override
  List<Object> get props => [product];
}
