// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountModel _$UserAccountModelFromJson(Map<String, dynamic> json) =>
    UserAccountModel(
      accessToken: json['accessToken'] as String,
      id: json['id'] as int,
      email: json['email'] as String,
      role: json['role'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$UserAccountModelToJson(UserAccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileImageUrl': instance.profileImageUrl,
      'accessToken': instance.accessToken,
    };
