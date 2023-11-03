import 'dart:async';

import 'package:auction_app/core/utils/app_util.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.targetDateTime});
  final DateTime targetDateTime;

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  Duration? remainingTime;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      remainingTime = widget.targetDateTime.difference(now);
      setState(() {
        if (remainingTime != null && remainingTime!.isNegative) {
          AppUtil.debugPrint('Countdown finished!');
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return remainingTime == null || remainingTime!.isNegative
        ? const SizedBox()
        : Text(
            '${remainingTime?.inDays} days, ${remainingTime!.inHours % 24} : ${remainingTime!.inMinutes % 60} : ${remainingTime!.inSeconds % 60}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          );
  }
}
