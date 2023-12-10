import 'package:auction_app/src/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {super.key, required this.onPressed, required this.buttonController});
  final Function() onPressed;
  final RoundedLoadingButtonController buttonController;

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
}
