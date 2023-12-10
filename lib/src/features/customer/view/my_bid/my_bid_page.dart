import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:auction_app/src/features/customer/view/my_bid/widgets/my_bid_list.dart';
import 'package:auction_app/src/features/customer/view/my_bid/widgets/my_bid_search_block.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBidPage extends StatelessWidget {
  const MyBidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<MyBidCubit>(context).getAllMyBids();
        },
        child: const CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: CustomSliverAppbar(
                title: "My Bids",
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 10),
              sliver: SliverToBoxAdapter(
                child: MyBidSearchBlock(),
              ),
            ),
            SliverToBoxAdapter(
              child: MyBidList(),
            )
          ],
        ),
      ),
    );
  }
}
