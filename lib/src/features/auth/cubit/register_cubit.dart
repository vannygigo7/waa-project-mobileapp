import 'package:auction_app/src/features/auth/cubit/register_state.dart';
import 'package:auction_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:auction_app/src/features/auth/model/user_account_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepository})
      : super(const RegisterState(status: RegisterStatus.initial));
  final AuthRepository authRepository;

  Future<void> register(String firstName, String lastName, String email,
      String password, String conPassword,
      {String role = UserRole.customer}) async {
    emit(state.copyWith(status: RegisterStatus.loading, message: ''));
    if (!_validateFields([firstName, lastName, email, password, conPassword])) {
      emit(state.copyWith(
          status: RegisterStatus.failure,
          message: 'Please fill all required fields*'));
      return;
    } else if (!_validateMatchPasswords(password, conPassword)) {
      emit(state.copyWith(
          status: RegisterStatus.failure,
          message: 'Password and Confirm password don\'t match'));
      return;
    }
    final result = await authRepository.register(RegisterRequestModel(
        email: email,
        password: password,
        role: role,
        firstName: firstName,
        lastName: lastName));
    result.fold(
      (failure) => emit(state.copyWith(
          status: RegisterStatus.failure, message: failure.message)),
      (data) {
        emit(state.copyWith(
            status: RegisterStatus.success,
            message: "Successfully registered"));
      },
    );
  }

  bool _validateFields(List fields) {
    for (var field in fields) {
      if (field.isEmpty) return false;
    }
    return true;
  }

  bool _validateMatchPasswords(String password, String conPassword) {
    if (password.trim() != conPassword.trim()) return false;

    return true;
  }
}
