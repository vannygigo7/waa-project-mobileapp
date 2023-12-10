import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';

import 'package:auction_app/src/features/customer/view/home/widgets/home_auction_list.dart';
import 'package:auction_app/src/features/customer/view/home/widgets/home_search_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<AuctionCubit>(context).getAll();
        },
        child: const CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: CustomSliverAppbar(
                title: "Auctions",
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 10),
              sliver: SliverToBoxAdapter(
                child: HomeSearchBlock(),
              ),
            ),
            SliverToBoxAdapter(
              child: HomeAuctionList(),
            )
          ],
        ),
      ),
    );
  }
}
