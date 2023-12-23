import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/auth/cubit/auth_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/impl/auth_repository_impl.dart';
import 'package:auction_app/src/features/auth/model/login_request_model.dart';
import 'package:auction_app/src/features/auth/view/login/widgets/login_button.dart';
import 'package:auction_app/src/features/auth/view/login/widgets/login_logo.dart';
import 'package:auction_app/src/features/auth/view/login/widgets/login_navigate_register.dart';

import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_dialog.dart';
import 'package:auction_app/src/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final RoundedLoadingButtonController _buttonController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _buttonController = RoundedLoadingButtonController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: Visibility(
          visible: !keyboardIsOpen, child: const LoginNavigateRegister()),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  _buildBody() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          _buttonController.reset();
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Login",
                  descriptions: state.message,
                );
              },
            );
          }
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const LoginLogo(),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              _buildEmailBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              _buildPasswordBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 18,
              ),
              _buildForgotPasswordBlcok(),
              const SizedBox(
                height: 25,
              ),
              _buildLoginButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return LoginButton(
      onPressed: () async {
        BlocProvider.of<AuthCubit>(context)
            .login(_emailController.text, _passwordController.text);
      },
      buttonController: _buttonController,
    );
  }

  Widget _buildForgotPasswordBlcok() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {},
        child: const Text(
          "Forgot Password",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailBlock() {
    return CustomTextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      leadingIcon: const Icon(
        Icons.email_outlined,
        color: Colors.grey,
      ),
      hintText: "Email",
    );
  }

  Widget _buildPasswordBlock() {
    return CustomTextField(
      controller: _passwordController,
      leadingIcon: const Icon(
        Icons.lock_outline,
        color: Colors.grey,
      ),
      obscureText: true,
      suffixIcon: GestureDetector(
        onTap: () {},
        child: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
      ),
      hintText: "Password",
    );
  }

  // _testLogin() {
  //   final authRepository = AuthRepositoryImpl(
  //       authDataSource:
  //           AuthRemoteDataSource(networkAPI: NetworkAPI(endpoint: '')));
  //   authRepository
  //       .login(LoginRequestModel(
  //           email: _emailController.text, password: _passwordController.text))
  //       .then((value) {
  //     _buttonController.reset();
  //     value.fold(
  //       (l) {
  //         if (mounted) {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return CustomDialogBox(
  //                 title: "Login",
  //                 descriptions: l.message,
  //               );
  //             },
  //           );
  //         }
  //       },
  //       (r) => AppNavigator.toAndReplace(context, const RootApp()),
  //     );
  //   }, onError: (error) {
  //     _buttonController.reset();
  //     if (mounted) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return CustomDialogBox(
  //             title: "Login",
  //             descriptions: error.message,
  //           );
  //         },
  //       );
  //     }
  //   });
  // }
}
