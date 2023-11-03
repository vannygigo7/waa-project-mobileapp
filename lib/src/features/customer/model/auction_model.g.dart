// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuctionModel _$AuctionModelFromJson(Map<String, dynamic> json) => AuctionModel(
      id: json['id'] as int,
      startPrice: (json['startPrice'] as num).toDouble(),
      depositAmount: (json['depositAmount'] as num).toDouble(),
      highestBid: (json['highestBid'] as num).toDouble(),
      bidDueDateTime: json['bidDueDateTime'] as String,
      payDate: json['payDate'] as String,
      isEnd: json['isEnd'] as bool,
      numberOfBidders: json['numberOfBidders'] as int,
      bids: (json['bids'] as List<dynamic>)
          .map((e) => BidModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuctionModelToJson(AuctionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startPrice': instance.startPrice,
      'depositAmount': instance.depositAmount,
      'highestBid': instance.highestBid,
      'bidDueDateTime': instance.bidDueDateTime,
      'payDate': instance.payDate,
      'isEnd': instance.isEnd,
      'numberOfBidders': instance.numberOfBidders,
      'bids': instance.bids.map((e) => e.toJson()).toList(),
    };
