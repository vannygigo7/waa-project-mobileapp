import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel extends Equatable {
  final String email;
  final String password;
  final String role;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;

  const RegisterRequestModel({
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

  @override
  List<Object?> get props =>
      [email, password, role, firstName, lastName, profileImageUrl];
}
