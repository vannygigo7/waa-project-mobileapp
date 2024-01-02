import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel extends Equatable {
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  @override
  List<Object?> get props => [email, password];
}
