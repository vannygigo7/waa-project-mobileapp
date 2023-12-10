import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/src/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:auction_app/src/features/auth/data/repository/impl/auth_repository_impl.dart';
import 'package:auction_app/src/features/auth/model/register_request_model.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_button.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_logo.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_navigate_login.dart';
import 'package:auction_app/src/root_app.dart';
import 'package:auction_app/src/widgets/custom_dialog.dart';
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
  final _buttonController = RoundedLoadingButtonController();

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
      floatingActionButton: Visibility(
          visible: !keyboardIsOpen, child: const RegisterNavigateLogin()),
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
            const RegisterLogo(),
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
            RegisterButton(
              onPressed: () {
                _testRegister();
              },
              buttonController: _buttonController,
            )
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
        .then((value) {
      _buttonController.reset();
      value.fold(
        (l) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Register",
                  descriptions: l.message,
                );
              },
            );
          }
        },
        (r) => AppNavigator.toAndReplace(context, const RootApp()),
      );
    }, onError: (error) {
      _buttonController.reset();
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Register",
              descriptions: error.message,
            );
          },
        );
      }
    });
  }
}
