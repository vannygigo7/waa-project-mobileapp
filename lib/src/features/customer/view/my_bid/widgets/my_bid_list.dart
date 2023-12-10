import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_state.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/auction_detail.dart';
import 'package:auction_app/src/widgets/custom_no_data.dart';
import 'package:auction_app/src/widgets/custom_progress_indicator.dart';
import 'package:auction_app/src/widgets/home_auction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBidList extends StatefulWidget {
  const MyBidList({super.key});

  @override
  State<MyBidList> createState() => _MyBidListState();
}

class _MyBidListState extends State<MyBidList> {
  @override
  void initState() {
    super.initState();
    context.read<MyBidCubit>().getAllMyBids();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBidCubit, MyBidState>(builder: (_, state) {
      switch (state.status) {
        case MyBidStatus.loading:
          return const CustomProgressIndicator();
        case MyBidStatus.success:
          return _buildItemList(state.products);
        case MyBidStatus.initial:
        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildItemList(List<ProductModel> products) {
    return products.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return AuctionItem(
                onTap: () {
                  AppNavigator.to(
                    context,
                    AuctionDetailPage(
                      product: products[index],
                    ),
                  );
                },
                product: products[index],
                width: MediaQuery.of(context).size.width,
              );
            },
          )
        : const CustomNoData();
  }
}
