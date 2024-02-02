import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:auction_app/src/widgets/favorite_box.dart';
import 'package:flutter/material.dart';

class HomeAuctionItem extends StatelessWidget {
  const HomeAuctionItem(
      {Key? key,
      required this.product,
      this.onTap,
      this.width = 200,
      this.height = 320})
      : super(key: key);
  final ProductModel product;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildAuctionImage(),
            Positioned(
              top: 170,
              right: 15,
              child: _buildFavoriteButton(),
            ),
            Positioned(
              top: 210,
              child: _buildCourseInfo(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return FavoriteBox(
      onTap: () {},
    );
  }

  Widget _buildCourseInfo() {
    return Container(
      width: width - 50,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildAttributeBlock(),
        ],
      ),
    );
  }

  Widget _buildAuctionImage() {
    return CustomImage(
      product.imageUrl,
      imageType: ImageType.network,
      width: width,
      height: 190,
      radius: 15,
    );
    // return Hero(
    //   tag: '${product.id}${product.imageUrl}',
    //   child: CustomImage(
    //     product.imageUrl,
    //     imageType: ImageType.network,
    //     width: width,
    //     height: 190,
    //     radius: 15,
    //   ),
    // );
  }

  Widget _buildAttributeBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCurrentPrice(),
        _bidDueDate(Icons.schedule_rounded, AppColor.white,
            AppUtil.formatDateTime(product.auction.bidDueDateTime)),
      ],
    );
  }

  Widget _buildCurrentPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppConstant.currency}${product.auction.highestBid}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "current price",
          style: TextStyle(color: AppColor.labelColor, fontSize: 12),
        )
      ],
    );
  }

  Widget _bidDueDate(IconData icon, Color color, String info) {
    return Card(
      color: AppColor.primary,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: color,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              info,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
