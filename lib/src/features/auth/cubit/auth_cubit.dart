import 'dart:async';

import 'package:auction_app/core/services/auth_manager.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(const AuthState()) {
    _streamSubscription = authRepository.status.listen((status) {
      emit(state.copyWith(status: status));
    });
  }

  final AuthRepository authRepository;
  late StreamSubscription _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  void checkAuthState() async {
    final authed = await AuthManager.instance.isAuthenticated();
    AppUtil.debugPrint("checkAuthState: $authed");
    if (authed) {
      var user = await AuthManager.instance.user;
      emit(state.copyWith(
          status: AuthStatus.authenticated,
          userAccount: user,
          message: "Authorized"));
    }
  }

  void logOut() async {
    AuthManager.instance.clearAuthUser();
    await authRepository.logOut();
  }
}
