import 'package:auction_app/src/features/customer/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_account_model.g.dart';

@JsonSerializable()
class UserAccountModel extends UserModel {
  UserAccountModel(
      {required this.accessToken,
      required super.id,
      required super.email,
      required super.role,
      required super.firstName,
      required super.lastName,
      required super.profileImageUrl});

  final String accessToken;

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserAccountModelToJson(this);
}

class UserRole {
  static const seller = 'SELLER';
  static const customer = 'USER';
}
