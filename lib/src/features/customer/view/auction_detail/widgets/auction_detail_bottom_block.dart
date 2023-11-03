import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_button.dart';
import 'package:auction_app/src/widgets/custom_textbox.dart';
import 'package:flutter/material.dart';

class CourseDetailBottomBlock extends StatelessWidget {
  const CourseDetailBottomBlock({required this.product, super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: CustomTextBox(
              prefix: Icon(Icons.attach_money),
              hint: "Enter your bid amount",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CustomButton(
            width: 110,
            height: 40,
            radius: 10,
            title: "Place Bid",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
