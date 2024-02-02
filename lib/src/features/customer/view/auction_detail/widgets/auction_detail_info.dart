import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/widgets/favorite_box.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class AuctionDetailInfo extends StatelessWidget {
  const AuctionDetailInfo({required this.product, super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const FavoriteBox(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            _buildCourseAttribute(Icons.sell_outlined, AppColor.labelColor,
                "stated at ${AppConstant.currency}${product.auction.startPrice}"),
            const SizedBox(
              width: 15,
            ),
            _buildCourseAttribute(Icons.schedule_rounded, AppColor.labelColor,
                AppUtil.formatDateTime(product.auction.bidDueDateTime)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Description:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        ReadMoreText(
          product.description,
          style: const TextStyle(color: AppColor.labelColor, height: 1.5),
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.red,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColor.labelColor, fontSize: 14),
        ),
      ],
    );
  }
}
