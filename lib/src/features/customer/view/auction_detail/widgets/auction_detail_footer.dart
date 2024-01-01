import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_state.dart';
import 'package:auction_app/src/features/customer/model/product_model.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_button.dart';
import 'package:auction_app/src/widgets/custom_textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AuctionDetailFooter extends StatefulWidget {
  AuctionDetailFooter({super.key, required this.product});
  ProductModel product;
  @override
  State<AuctionDetailFooter> createState() => _AuctionDetailFooterState();
}

class _AuctionDetailFooterState extends State<AuctionDetailFooter> {
  final _bidAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bidAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextBox(
              controller: _bidAmountController,
              keyboardType: TextInputType.number,
              prefix: const Icon(Icons.attach_money),
              hint: "Enter your bid amount",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<AddBidCubit, AddBidState>(
            builder: (context, state) {
              return CustomButton(
                width: 110,
                height: 40,
                radius: 10,
                title: "Place Bid",
                isLoading: state.status == AddBidStatus.loading,
                onTap: () async {
                  AppUtil.debugPrint(_bidAmountController.text);
                  context.read<AddBidCubit>().add(widget.product.id,
                      double.tryParse(_bidAmountController.text) ?? 0);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
