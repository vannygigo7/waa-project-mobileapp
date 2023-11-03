import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:flutter/material.dart';

class AuctionDetailBanner extends StatelessWidget {
  const AuctionDetailBanner({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return _buildAuctionBanner();
  }

  Widget _buildAuctionBanner() {
    return Card(
      color: product.auction.isEnd ? AppColor.labelColor : AppColor.primary,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildCurrentPrice(), _buildAuctionTimer()],
        ),
      ),
    );
  }

  Widget _buildCurrentPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${AppConstant.currency}${product.auction.highestBid}",
          style: const TextStyle(
              color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Text(
          "current price",
          style: TextStyle(color: AppColor.white, fontSize: 13),
        )
      ],
    );
  }

  Widget _buildAuctionTimer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppUtil.formatDateTime(product.auction.bidDueDateTime),
          style: const TextStyle(
              color: AppColor.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const Text(
          "auction ends",
          style: TextStyle(color: AppColor.white, fontSize: 13),
        )
      ],
    );
  }
}
