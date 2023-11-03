import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final String profileImageUrl;

  UserModel({
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
