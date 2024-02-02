import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/src/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;

/// AppUtil provides helper methods
class AppUtil {
  /// prints only in debug mode
  static void debugPrint(var value) {
    if (kDebugMode) print(value);
  }

  /// checks if [value] is null
  static bool checkIsNull(value) {
    return [null, "null", ""].contains(value);
  }

  /// shows snackbar with [message]
  static void showSnackBar(BuildContext context, String message,
      {int duration = 2}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: duration),
        ),
      );
  }

  /// format DateTime [dateTime] to string time ago
  static String formatTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime, allowFromNow: true, locale: 'en_short');
  }

  /// show custom confirm dialog with [message]
  static Future<bool> showConfirmDialog(BuildContext context, String message,
      {okTitle = "Ok", cancelTitle = "Cancel"}) async {
    bool res = false;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(true);
              res = true;
            },
            child: Text(
              okTitle,
              style: const TextStyle(color: AppColor.actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            cancelTitle,
            style: const TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
    );
    return res;
  }

  static String formatDateTime(datetime, {type = 0}) {
    if (['', null, 0].contains(datetime)) return "N/A";
    String formattedDate =
        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(datetime));
    if (type == 1) {
      formattedDate =
          DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.parse(datetime));
    } else if (type == 2) {
      formattedDate = DateFormat("dd/MM/yyyy").format(DateTime.parse(datetime));
    } else if (type == 3) {
      formattedDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(datetime));
    } else if (type == 4) {
      formattedDate = DateFormat("hh:mm a").format(DateTime.parse(datetime));
    }
    return formattedDate;
  }

  static bool compareDateTimes(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.isBefore(dateTime2);
  }

  static void showToast(String message, BuildContext context,
      {int duration = 2, CustomToastType type = CustomToastType.normal}) {
    var fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: CustomToast(
        message: message,
        type: type,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }

  static Future<void> store(
      {required String key, required dynamic value}) async {
    await const FlutterSecureStorage().write(key: key, value: value);
  }

  static Future<void> storeAll(Map<String, String> map) async {
    const store = FlutterSecureStorage();
    for (MapEntry element in map.entries) {
      store.write(key: element.key, value: element.value);
    }
  }

  static Future<String?> read(String key) async {
    return await const FlutterSecureStorage().read(key: key);
  }

  static Future<Map<String, String>> readAll() async {
    const storage = FlutterSecureStorage();
    return await storage.readAll();
  }

  static Future<void> deleteAll() async {
    await const FlutterSecureStorage().deleteAll();
  }

  static Future<void> delete(String key) async {
    await const FlutterSecureStorage().delete(key: key);
  }
}
