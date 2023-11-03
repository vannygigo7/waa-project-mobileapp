import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class AuctionDetailImage extends StatelessWidget {
  const AuctionDetailImage(
      {required this.product, this.isHero = false, super.key});
  final ProductModel product;
  final bool isHero;

  @override
  Widget build(BuildContext context) {
    return isHero
        ? Hero(
            tag: '${product.id}${product.imageUrl}',
            child: CustomImage(
              product.imageUrl,
              imageType: ImageType.network,
              radius: 10,
              width: double.infinity,
              height: 220,
            ),
          )
        : CustomImage(
            product.imageUrl,
            imageType: ImageType.network,
            radius: 10,
            width: double.infinity,
            height: 220,
          );
  }
}
