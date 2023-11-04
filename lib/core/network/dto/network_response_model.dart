import 'package:json_annotation/json_annotation.dart';
part 'network_response_model.g.dart';

@JsonSerializable()
class NetworkResponseModel {
  final int statusCode;
  final String message;
  final dynamic data;

  NetworkResponseModel(
      {required this.statusCode, required this.message, required this.data});

  factory NetworkResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkResponseModelToJson(this);
}
