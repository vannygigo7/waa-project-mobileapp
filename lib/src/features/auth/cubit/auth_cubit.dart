import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(const AuthState());
  final AuthRepository authRepository;

  login(String email, String password) async {
    if (!_validateForm(email, password)) {
      emit(const AuthState(
          status: AuthStatus.warning,
          message: 'Please enter all required fields'));
    }
    emit(const AuthState(status: AuthStatus.loading));
    final result = await authRepository
        .login(LoginRequestModel(email: email, password: password));
    result.fold(
      (l) => emit(AuthState(status: AuthStatus.error, message: l.message)),
      (r) => emit(AuthState(
          status: AuthStatus.authenticated,
          userAccount: r,
          message: "Successfully login")),
    );
  }

  bool _validateForm(String email, String password) {
    if (email.isEmpty) {
      return false;
    } else if (password.isEmpty) {
      return false;
    }

    return true;
  }
}
