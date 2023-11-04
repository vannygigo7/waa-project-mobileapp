import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_textbox.dart';
import 'package:auction_app/src/widgets/icon_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBidSearchBlock extends StatefulWidget {
  const MyBidSearchBlock({super.key});

  @override
  State<MyBidSearchBlock> createState() => _MyBidSearchBlockState();
}

class _MyBidSearchBlockState extends State<MyBidSearchBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          const Expanded(
            child: CustomTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            bgColor: AppColor.primary,
            radius: 10,
            onTap: () {},
            child: SvgPicture.asset(
              "assets/icons/filter.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
    );
  }
}
