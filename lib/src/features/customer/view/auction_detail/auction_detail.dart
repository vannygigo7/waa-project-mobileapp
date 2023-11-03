import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_banner.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_bid_list.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_bottom_block.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_image.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_appbar.dart';
import 'package:auction_app/src/widgets/timer_widget.dart';
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
      appBar: CustomAppBar(
        title: TimerWidget(
          targetDateTime: DateTime.parse(product.auction.bidDueDateTime),
        ),
      ),
      body: _buildBody(context),
      bottomNavigationBar: CourseDetailBottomBlock(product: product),
    );
  }

  Widget _buildBody(context) {
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
          AuctionDetailBanner(
            product: product,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.darker,
            ),
          ),
          TextButton(
            onPressed: () {
              handleShowBottomSheet(context);
            },
            child: const Text("More Info"),
          ),
          Divider(
            color: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Bidders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          AuctionDetailBidList(
            bids: product.auction.bids,
          ),
        ],
      ),
    );
  }

  handleShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView(
              children: <Widget>[
                const Text(
                  "Auction",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildBottomSheetItem(
                    Icons.currency_exchange_outlined,
                    "current bid",
                    "${AppConstant.currency}${product.auction.highestBid}"),
                _buildBottomSheetItem(
                    Icons.account_balance_wallet_outlined,
                    "deposit",
                    "${AppConstant.currency}${product.auction.depositAmount}"),
                _buildBottomSheetItem(
                    Icons.event_available_outlined,
                    "auction due",
                    AppUtil.formatDateTime(product.auction.bidDueDateTime)),
                _buildBottomSheetItem(Icons.event_outlined, "payment due",
                    AppUtil.formatDateTime(product.auction.payDate)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.grey.shade300,
                  ),
                ),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildBottomSheetItem(
                    Icons.sell_outlined, "categories", "Camera"),
                _buildBottomSheetItem(Icons.paid_outlined, "started at",
                    "${AppConstant.currency}${product.auction.startPrice}"),
                _buildBottomSheetItem(Icons.info_outline, "description", ""),
                const SizedBox(
                  height: 5,
                ),
                Text(product.description),
              ],
            ),
          );
        });
  }

  Widget _buildBottomSheetItem(IconData icon, String label, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColor.labelColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text("$label:"),
          const SizedBox(
            width: 5,
          ),
          Text(data),
        ],
      ),
    );
  }
}
