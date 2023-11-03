import 'package:auction_app/src/features/customer/model/bid_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuctionModel {
  final int id;
  final double startPrice;
  final double depositAmount;
  final double highestBid;
  final String bidDueDateTime;
  final String payDate;
  final bool isEnd;
  final int numberOfBidders;
  final List<BidModel> bids;

  AuctionModel(
      {required this.id,
      required this.startPrice,
      required this.depositAmount,
      required this.highestBid,
      required this.bidDueDateTime,
      required this.payDate,
      required this.isEnd,
      required this.numberOfBidders,
      required this.bids});

  factory AuctionModel.fromJson(Map<String, dynamic> json) =>
      _$AuctionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuctionModelToJson(this);
}
