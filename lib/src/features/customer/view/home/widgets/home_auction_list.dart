import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_state.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/auction_detail.dart';
import 'package:auction_app/src/features/customer/view/home/widgets/home_auction_item.dart';
import 'package:auction_app/src/widgets/custom_no_data.dart';
import 'package:auction_app/src/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAuctionList extends StatefulWidget {
  const HomeAuctionList({super.key});

  @override
  State<HomeAuctionList> createState() => _HomeAuctionListState();
}

class _HomeAuctionListState extends State<HomeAuctionList> {
  @override
  void initState() {
    super.initState();
    context.read<AuctionCubit>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionState>(
      listener: (context, state) {
        if (state is AuctionError) {
          AppUtil.showSnackBar(state.errorMessage, context);
        }
      },
      builder: (context, state) {
        if (state is AuctionLoading) {
          return const CustomProgressIndicator();
        } else if (state is AuctionLoaded) {
          return _buildItemList(state.products);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildItemList(List<ProductModel> products) {
    return products.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return HomeAuctionItem(
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
