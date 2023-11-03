import 'package:auction_app/core/utils/app_asset.dart';
import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/src/features/auth/pages/register_page.dart';
import 'package:auction_app/src/features/auth/pages/widgets/login_button.dart';
import 'package:auction_app/src/features/customer/view/home/home_page.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:auction_app/src/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final buttonController = RoundedLoadingButtonController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
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
      body: buildBody(),
      floatingActionButton:
          Visibility(visible: !keyboardIsOpen, child: getNavigationButton()),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildLogo(),
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
    );
  }

  Widget _buildForgotPasswordBlcok() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {},
        child: const Text(
          "Password",
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 150,
        height: 150,
        child: CustomImage(
          AppAsset.logo,
          padding: 10,
          bgColor: Theme.of(context).scaffoldBackgroundColor,
          radius: 5,
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
      suffixIcon: GestureDetector(
        onTap: () {},
        child: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
      ),
      hintText: "Password",
    );
  }

  Widget _buildLoginButton() {
    return LoginButton(
        onPressed: () {
          AppNavigator.to(context, const HomePage());
        },
        buttonController: buttonController);
  }

  Widget getNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            AppNavigator.to(context, const RegisterPage());
          },
          child: Container(
            width: 90,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: const Text(
              "Register",
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}
