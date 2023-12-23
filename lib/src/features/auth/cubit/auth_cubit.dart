import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(const AuthState());
  final AuthRepository authRepository;

  void login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    if (!_validateForm(email, password)) {
      emit(state.copyWith(
          status: AuthStatus.error,
          message: 'Please enter email and password'));
      return;
    }
    final result = await authRepository
        .login(LoginRequestModel(email: email, password: password));
    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.error, message: l.message)),
      (r) => emit(state.copyWith(
          status: AuthStatus.authenticated,
          userAccount: r,
          message: "Successfully login")),
    );
  }

  void logOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: AuthStatus.unAuthenticated, userAccount: null));
  }

  bool _validateForm(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    return true;
  }
}
