import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/src/features/auth/view/register/register_page.dart';
import 'package:flutter/material.dart';

class LoginNavigateRegister extends StatelessWidget {
  const LoginNavigateRegister({super.key});

  @override
  Widget build(BuildContext context) {
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
