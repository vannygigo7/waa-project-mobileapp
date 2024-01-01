import 'package:auction_app/src/features/auth/cubit/register_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/register_state.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_button.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_logo.dart';
import 'package:auction_app/src/features/auth/view/register/widgets/register_navigate_login.dart';
import 'package:auction_app/src/widgets/custom_dialog.dart';
import 'package:auction_app/src/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _conPasswordController;
  late final RoundedLoadingButtonController _buttonController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _conPasswordController = TextEditingController();
    _buttonController = RoundedLoadingButtonController();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.failure) {
          _buttonController.reset();
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Register",
                  descriptions: state.message,
                );
              },
            );
          }
        } else if (state.status == RegisterStatus.success) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Register",
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
              _buildFirstNameBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildLastNameBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildEmailBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildPassowrdBlcok(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildConPassowrdBlock(),
              const Divider(
                color: Colors.grey,
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterButton(
                onPressed: _onRegister,
                buttonController: _buttonController,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onRegister() async {
    BlocProvider.of<RegisterCubit>(context).register(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _conPasswordController.text.trim());
  }

  Widget _buildFirstNameBlock() {
    return CustomTextField(
      controller: _firstNameController,
      leadingIcon: const Icon(
        Icons.person_outline,
        color: Colors.grey,
      ),
      hintText: "First name*",
    );
  }

  Widget _buildLastNameBlock() {
    return CustomTextField(
      controller: _lastNameController,
      leadingIcon: const Icon(
        Icons.person_outline,
        color: Colors.grey,
      ),
      hintText: "Last name*",
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
      hintText: "Email*",
    );
  }

  Widget _buildConPassowrdBlock() {
    return CustomTextField(
      controller: _conPasswordController,
      leadingIcon: const Icon(
        Icons.lock_outline,
        color: Colors.grey,
      ),
      obscureText: true,
      suffixIcon: GestureDetector(
        onTap: () {},
        child: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
      ),
      hintText: "Confirm password*",
    );
  }

  Widget _buildPassowrdBlcok() {
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
      hintText: "Password*",
    );
  }
}
