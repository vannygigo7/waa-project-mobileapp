// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidModel _$BidModelFromJson(Map<String, dynamic> json) => BidModel(
      id: json['id'] as int,
      bidAmount: (json['bidAmount'] as num).toDouble(),
      bidDateTime: json['bidDateTime'] as String,
      customer: UserModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BidModelToJson(BidModel instance) => <String, dynamic>{
      'id': instance.id,
      'bidAmount': instance.bidAmount,
      'bidDateTime': instance.bidDateTime,
      'customer': instance.customer.toJson(),
    };
