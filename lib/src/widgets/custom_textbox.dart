import 'package:auction_app/src/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    Key? key,
    this.hint = "",
    this.prefix,
    this.suffix,
    this.controller,
    this.readOnly = false,
  }) : super(key: key);

  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.textBoxColor,
        border: Border.all(color: AppColor.textBoxColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
