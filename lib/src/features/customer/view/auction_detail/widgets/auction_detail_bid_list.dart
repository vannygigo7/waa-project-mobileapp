import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/src/features/customer/model/bid_model.dart';
import 'package:auction_app/src/features/customer/view/auction_detail/widgets/auction_detail_bid_tile.dart';
import 'package:flutter/material.dart';

class AuctionDetailBidList extends StatelessWidget {
  const AuctionDetailBidList({super.key, required this.bids});
  final List<BidModel> bids;
  @override
  Widget build(BuildContext context) {
    return bids.isEmpty
        ? const Center(
            child: Text(
              "No bid",
              style: TextStyle(fontSize: 16),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: bids.length,
            itemBuilder: (context, index) {
              return AuctionDetailBidTile(
                bid: bids[index],
                bidAmountColor:
                    index == bids.length - 1 ? AppColor.green : AppColor.grey,
              );
            },
          );
  }
}
