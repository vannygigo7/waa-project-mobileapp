import 'package:auction_app/core/network/network_api.dart';
import 'package:auction_app/core/utils/endpoint_constant.dart';
import 'package:auction_app/src/features/customer/data/datasource/remote/auction_remote_datasource.dart';
import 'package:auction_app/src/features/customer/data/repository/auction_repository.dart';
import 'package:auction_app/src/features/customer/data/repository/impl/auction_repository_impl.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';

import 'package:auction_app/src/features/customer/view/home/widgets/home_auction_list.dart';
import 'package:auction_app/src/features/customer/view/home/widgets/home_search_block.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuctionRepository auctionRepository = AuctionRepositoryImpl(
      auctionDataSource: AuctionRemoteDataSource(
          networkAPI: NetworkAPI(endpoint: EndpointConstant.home)));

  @override
  Widget build(BuildContext context) {
    auctionRepository.getAll();
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
              title: "Auctions",
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
          HomeSearchBlock(),
          SizedBox(height: 10),
          HomeAuctionList(),
        ],
      ),
    );
  }
}
