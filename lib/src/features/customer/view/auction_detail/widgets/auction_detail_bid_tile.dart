import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_asset.dart';
import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/model/bid_model.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class AuctionDetailBidTile extends StatelessWidget {
  const AuctionDetailBidTile(
      {Key? key, required this.bid, this.bidAmountColor = AppColor.grey})
      : super(key: key);
  final BidModel bid;
  final Color bidAmountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImage(
              bid.customer.profileImageUrl ?? AppAsset.defaultProfile,
              imageType: bid.customer.profileImageUrl != null
                  ? ImageType.network
                  : ImageType.asset,
              radius: 100,
              height: 45,
              width: 45,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${bid.customer.firstName} ${bid.customer.lastName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColor.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppUtil.formatTimeAgo(DateTime.parse(bid.bidDateTime)),
                    style: const TextStyle(
                        fontSize: 12, color: AppColor.labelColor),
                  ),
                ],
              ),
            ),
            Card(
              color: bidAmountColor,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "${AppConstant.currency}${bid.bidAmount}",
                  style: const TextStyle(
                      color: AppColor.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ));
  }
}
