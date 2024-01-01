import 'dart:async';

import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:auction_app/src/widgets/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBidSearchBlock extends StatefulWidget {
  const MyBidSearchBlock({super.key});

  @override
  State<MyBidSearchBlock> createState() => _MyBidSearchBlockState();
}

class _MyBidSearchBlockState extends State<MyBidSearchBlock> {
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
      child: CustomTextBox(
        hint: "Search",
        prefix: const Icon(Icons.search, color: Colors.grey),
        onChanged: _onSearchChanged,
      ),
    );
  }

  _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<MyBidCubit>(context).getMyBidsByTitle(title: text);
    });
  }
}
