import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Provider/get/offersProvider.dart';

class CountdownWaitnigDriver extends StatefulWidget {
  final DateTime createdAt;
  final int period;
  final int id;

  CountdownWaitnigDriver({this.createdAt, this.period, this.id});
  @override
  State<StatefulWidget> createState() => _CountdownWaitnigDriverState();
}

class _CountdownWaitnigDriverState extends State<CountdownWaitnigDriver> {
  Timer _timer;
  DateTime _currentTime;
  DateTime calculatefinishOfOffer(DateTime time) {
    return DateTime(time.year, time.month, time.day, time.hour, time.minute,
        time.second + widget.period);
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

  void whentimeFinsih() async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final finishofAuction = calculatefinishOfOffer(widget.createdAt);
    final remaining = finishofAuction.difference(_currentTime);

    final hours = remaining.inHours - remaining.inDays * 24;
    final minutes = remaining.inMinutes - remaining.inHours * 60;
    final seconds = remaining.inSeconds - remaining.inMinutes * 60;

    final formattedRemaining = '$seconds : $minutes ';
    if (hours <= 0 && minutes <= 0 && seconds < 0) {
      whentimeFinsih();
    }

    return FittedBox(
      child: Text(
        "سيتم تحديث الصفحه خلال $formattedRemaining دقائق",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
