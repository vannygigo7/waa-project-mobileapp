import 'dart:async';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';

class AuthManager {
  static const String _accessTokenKey = 'accessToken';
  static String? _token;
  static UserAccountModel? _user;
  static AuthManager? _instance;
  final _streamController = StreamController<String?>.broadcast();

  static AuthManager get instance => _instance ??= AuthManager._();
  AuthManager._();

  /// Getter for accessing the stored access token as stream
  Stream<String?> get accessTokenStream => _streamController.stream;

  /// Getter for accessing the stored auth user
  Future<UserAccountModel?> get user async {
    if (_user == null) {
      Map<String, dynamic> userMap = await AppUtil.readAll();
      if (userMap.isEmpty) return null;
      Map<String, dynamic> newMap = {...userMap};
      newMap['id'] = int.parse(userMap['id']);
      _user = UserAccountModel.fromJson(newMap);
    }
    return _user;
  }

  /// Setter for storing auth user
  Future<void> setAuthUser(UserAccountModel user) async {
    _user = user;
    _token = user.accessToken;
    _streamController.add(_token);
    Map<String, String> stringMap =
        user.toJson().map((key, value) => MapEntry(key, value.toString()));
    await AppUtil.storeAll(stringMap);
  }

  /// Method for removing auth user and token
  Future<void> clearAuthUser() async {
    _user = null;
    _token = null;
    _streamController.add(null);
    await AppUtil.deleteAll();
  }

  /// Getter for accessing the stored access token
  Future<String?> get accessToken async {
    _token = _token ?? await AppUtil.read(_accessTokenKey);
    return _token;
  }

  /// Setter for storing the access token
  Future<void> setAccessToken(String accessToken) async {
    _token = accessToken;
    _streamController.add(_token);
    await AppUtil.store(key: _accessTokenKey, value: accessToken);
  }

  /// Method for checking if the user is authenticated (has an access token)
  Future<bool> isAuthenticated() async {
    _token = _token ?? await AppUtil.read(_accessTokenKey);
    _streamController.add(_token);
    return _token != null;
  }

  /// Method for clearing the access token (user logout)
  Future<void> clearAccessToken() async {
    _token = null;
    _streamController.add(_token);
    await AppUtil.delete(_accessTokenKey);
  }

  dispose() {
    _streamController.close();
  }
}
