import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  String email;
  String password;
  String role;
  String firstName;
  String lastName;
  String? profileImageUrl;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
