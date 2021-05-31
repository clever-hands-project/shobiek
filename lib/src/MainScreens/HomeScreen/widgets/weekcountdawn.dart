import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';

class WeekCountdown extends StatefulWidget {
  final DateTime createdAt;
  final int period;

  WeekCountdown({this.createdAt, this.period});
  @override
  State<StatefulWidget> createState() => _WeekCountdownState();
}

class _WeekCountdownState extends State<WeekCountdown> {
  Timer _timer;
  DateTime _currentTime;
  DateTime calculatefinishOfOffer(DateTime time) {
    return DateTime(time.year, time.month, time.day, time.hour,
        time.minute + widget.period, time.second);
  }

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  void whentimeFinsih() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(pageBuilder: (_, __, ___) => MainPage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final finishofAuction = calculatefinishOfOffer(widget.createdAt);
    final remaining = finishofAuction.difference(_currentTime);

    final hours = remaining.inHours - remaining.inDays * 24;
    final minutes = remaining.inMinutes - remaining.inHours * 60;
    final seconds = remaining.inSeconds - remaining.inMinutes * 60;

    final formattedRemaining = '$seconds : $minutes : $hours ';
    if (hours <= 0 && minutes <= 0 && seconds < 0) {
      whentimeFinsih();
    }

    return FittedBox(
      child: Text(
        "$formattedRemaining ساعات",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
