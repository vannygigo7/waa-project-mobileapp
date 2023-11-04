// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkResponseModel _$NetworkResponseModelFromJson(
        Map<String, dynamic> json) =>
    NetworkResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$NetworkResponseModelToJson(
        NetworkResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
