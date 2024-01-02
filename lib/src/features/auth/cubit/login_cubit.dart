import 'package:auction_app/core/services/auth_manager.dart';
import 'package:auction_app/src/features/auth/cubit/login_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository})
      : super(const LoginState(status: LoginStatus.initial));
  final AuthRepository authRepository;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading, message: ''));
    if (!_validateFields([email, password])) {
      emit(state.copyWith(
          status: LoginStatus.failure,
          message: 'Please enter email and password'));
      return;
    }
    final result = await authRepository
        .login(LoginRequestModel(email: email, password: password));
    result.fold(
      (failure) => emit(state.copyWith(
          status: LoginStatus.failure, message: failure.message)),
      (data) {
        AuthManager.instance.setAuthUser(data);
        emit(state.copyWith(
            status: LoginStatus.success,
            userAccount: data,
            message: "Successfully login"));
      },
    );
  }

  bool _validateFields(List fields) {
    for (var field in fields) {
      if (field.isEmpty) return false;
    }
    return true;
  }
}
