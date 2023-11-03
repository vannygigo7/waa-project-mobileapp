import 'package:auction_app/src/theme/app_color.dart';
import 'package:flutter/material.dart';

import 'package:auction_app/src/features/customer/view/home/widgets/home_appbar.dart';
import 'package:auction_app/src/features/customer/view/home/widgets/home_auction_list.dart';
import 'package:auction_app/src/features/customer/view/home/widgets/home_search_block.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: HomeAppbar(),
          ),
          SliverToBoxAdapter(
            child: _buildBody(),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HomeSearchBlock(),
          SizedBox(height: 10),
          HomeAuctionList(),
        ],
      ),
    );
  }
}
