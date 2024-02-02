import 'package:auction_app/core/styles/app_color.dart';
import 'package:flutter/material.dart';

enum CustomToastType { normal, success, error, warning }

class CustomToast extends StatelessWidget {
  const CustomToast(
      {super.key, required this.message, this.type = CustomToastType.normal});
  final String message;
  final CustomToastType type;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.primary;
    var icon = Icons.info_outline;
    if (type == CustomToastType.success) {
      color = AppColor.green;
      icon = Icons.check_circle_outline;
    } else if (type == CustomToastType.error) {
      color = AppColor.red;
      icon = Icons.cancel_outlined;
    } else if (type == CustomToastType.warning) {
      color = AppColor.yellow;
      icon = Icons.warning_amber_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
