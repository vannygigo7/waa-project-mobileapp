import 'package:auction_app/core/utils/app_navigate.dart';
import 'package:auction_app/core/utils/dummy_data.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/auction_detail.dart';
import 'package:auction_app/src/widgets/home_auction_item.dart';
import 'package:flutter/material.dart';

class MyBidList extends StatefulWidget {
  const MyBidList({super.key});

  @override
  State<MyBidList> createState() => _MyBidListState();
}

class _MyBidListState extends State<MyBidList> {
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();

    products = productsData.map((p) => ProductModel.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _buildItemList(products);
  }

  Widget _buildItemList(List<ProductModel> products) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
    );
  }
}
