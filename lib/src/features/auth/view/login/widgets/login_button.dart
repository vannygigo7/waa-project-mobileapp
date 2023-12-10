import 'package:auction_app/src/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key, required this.onPressed, required this.buttonController});
  final RoundedLoadingButtonController buttonController;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RoundedLoadingButton(
            width: MediaQuery.of(context).size.width,
            color: AppColor.primary,
            controller: buttonController,
            onPressed: onPressed,
            child: const Text(
              "Login",
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
}
