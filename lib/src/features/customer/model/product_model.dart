import 'package:json_annotation/json_annotation.dart';

import 'package:auction_app/src/features/customer/model/auction_model.dart';
import 'package:auction_app/src/features/customer/model/category_model.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final List<CategoryModel> categories;
  final bool released;
  final AuctionModel auction;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.categories,
      required this.released,
      required this.auction});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, categories: $categories, released: $released, auction: $auction)';
  }
}
