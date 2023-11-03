import 'package:auction_app/src/features/customer/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bid_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BidModel {
  final int id;
  final double bidAmount;
  final String bidDateTime;
  final UserModel customer;

  BidModel(
      {required this.id,
      required this.bidAmount,
      required this.bidDateTime,
      required this.customer});

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);
  Map<String, dynamic> toJson() => _$BidModelToJson(this);
}
