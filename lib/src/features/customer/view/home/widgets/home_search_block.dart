import 'dart:async';

import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/widgets/custom_textbox.dart';
import 'package:auction_app/src/widgets/icon_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeSearchBlock extends StatefulWidget {
  const HomeSearchBlock({super.key});

  @override
  State<HomeSearchBlock> createState() => _HomeSearchBlockState();
}

class _HomeSearchBlockState extends State<HomeSearchBlock> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
              hint: "Search",
              prefix: const Icon(Icons.search, color: Colors.grey),
              onChanged: _onSearchChanged,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            bgColor: AppColor.primary,
            radius: 10,
            onTap: () {
              AppUtil.showSnackBar(context, "coming soon!");
            },
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

  _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<AuctionCubit>(context).getAll(params: 'name=$text');
    });
  }
}
