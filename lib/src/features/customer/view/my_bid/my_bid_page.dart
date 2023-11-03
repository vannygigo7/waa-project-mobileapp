import 'package:auction_app/src/features/customer/view/my_bid/widgets/my_bid_list.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';

class MyBidPage extends StatelessWidget {
  const MyBidPage({super.key});

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
            title: CustomSliverAppbar(
              title: "My Bids",
            ),
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
          SizedBox(height: 10),
          MyBidList(),
        ],
      ),
    );
  }
}
