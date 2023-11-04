import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/app_asset.dart';
import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/src/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/impl/auth_repository_impl.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:auction_app/src/root_app.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:auction_app/src/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();
  final btnController = RoundedLoadingButtonController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _conPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: _buildBody(),
      floatingActionButton:
          Visibility(visible: !keyboardIsOpen, child: getNavigationButton()),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  _buildBody() {
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
                "Register",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            _buildNameBlock(),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildEmailBlock(),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildPassowrdBlcok(),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildConPassowrdBlock(),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildRegisterButton()
          ],
        ),
      ),
    );
  }

  Widget _buildNameBlock() {
    return CustomTextField(
      controller: _nameController,
      leadingIcon: const Icon(
        Icons.person_outline,
        color: Colors.grey,
      ),
      hintText: "Name",
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

  Widget _buildConPassowrdBlock() {
    return CustomTextField(
      controller: _conPasswordController,
      leadingIcon: const Icon(
        Icons.lock_outline,
        color: Colors.grey,
      ),
      suffixIcon: GestureDetector(
        onTap: () {},
        child: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
      ),
      hintText: "Confirm password",
    );
  }

  Widget _buildPassowrdBlcok() {
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

  _testRegister() {
    final authRepository = AuthRepositoryImpl(
        authDataSource:
            AuthRemoteDataSource(networkAPI: NetworkAPI(endpoint: '')));
    authRepository
        .register(RegisterRequestModel(
            email: _emailController.text,
            password: _passwordController.text,
            role: "USER",
            firstName: _nameController.text,
            lastName: _nameController.text,
            profileImageUrl: ''))
        .then(
          (value) => AppNavigator.toAndReplace(context, const RootApp()),
        );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RoundedLoadingButton(
            width: MediaQuery.of(context).size.width,
            color: AppColor.primary,
            controller: btnController,
            onPressed: () async {
              _testRegister();
            },
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppNavigator.back(context);
          },
          child: Container(
            width: 80,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
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
              "Login",
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
