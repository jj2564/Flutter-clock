import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IrvingClock extends StatefulWidget {
  const IrvingClock(this.model);

  final ClockModel model;

  @override
  _IrvingClockState createState() => _IrvingClockState();
}

class _IrvingClockState extends State<IrvingClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.dispose();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update per second.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final year = DateFormat('yyyy').format(_dateTime);
    final month = DateFormat('MM').format(_dateTime);
    final day = DateFormat('dd').format(_dateTime);
    final hour = DateFormat('HH').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 10;

    final firstLine = year + "  " + month + "  " + day;
    final secondLine = hour + ":" + minute + "  " + second;

    final textStyle = TextStyle(
      color: Color(0xFF4A4A5A),
      fontFamily: 'digital',
      fontSize: fontSize,
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.cover,
        )
      ),
      child: Center(
        child: DefaultTextStyle(
          style: textStyle,
          child: Stack(
            children: <Widget>[
              Positioned(left: 30, top: 15,  child: Text(firstLine)),
              Positioned(left: 30, top: 105,  child: Text(secondLine)),
            ],
          ),
        ),
      ),
    );
  }
}
