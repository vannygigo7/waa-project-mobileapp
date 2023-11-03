import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_bottom_block.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_image.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_info.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AuctionDetailPage extends StatelessWidget {
  const AuctionDetailPage(
      {required this.product, this.isHero = false, Key? key})
      : super(key: key);
  final ProductModel product;
  final bool isHero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      appBar: const CustomAppBar(title: "10:30:11"),
      body: _buildBody(),
      bottomNavigationBar: CourseDetailBottomBlock(product: product),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuctionDetailImage(
            product: product,
            isHero: isHero,
          ),
          const SizedBox(
            height: 15,
          ),
          AuctionDetailInfo(
            product: product,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
