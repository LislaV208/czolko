import 'dart:async';

import 'package:flutter/material.dart';

import '../models/song.dart';
import 'animated_opacity_widget.dart';
import 'shadow_text.dart';

class SongScreen extends StatefulWidget {
  final Song song;
  final Function onTimerExpired;

  SongScreen(this.song, this.onTimerExpired);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 30),
          child: AnimatedOpacityWidget(
            ShadowText(
              'Zanuć',
              offset: 4,
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: AnimatedOpacityWidget(
              ShadowText(
                widget.song.title.toUpperCase(),
                // 'Słodkiego miłego życia'.toUpperCase(),
                offset: 6,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacityWidget(
            _TimerText(widget.onTimerExpired),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16, right: 20),
          width: double.infinity,
          alignment: Alignment.bottomRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 180),
            child: AnimatedOpacityWidget(
              ShadowText(
                widget.song.artist.toUpperCase(),
                // 'imagine dragons'.toUpperCase(),
                offset: 2.5,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerText extends StatefulWidget {
  final Function onTimerExpired;

  _TimerText(this.onTimerExpired);
  @override
  __TimerTextState createState() => __TimerTextState();
}

class __TimerTextState extends State<_TimerText> {
  Timer _timer;
  // int _timeLeft = 5;
  Duration _timeLeft = Duration(seconds: 45);
  // Duration _timeLeft = Duration(seconds: 999);

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) => _onSecondElapsed(),
    );
  }

  void _onSecondElapsed() {
    setState(() {
      _timeLeft -= Duration(seconds: 1);
    });

    if (_timeLeft.inMilliseconds <= 0) {
      _timer.cancel();
      widget.onTimerExpired();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _stringTimeLeft() {
    String digits(int n, int width) => n.toString().padLeft(width, "0");
    String oneDigitMinutes = digits(_timeLeft.inMinutes.remainder(60), 1);
    String twoDigitSeconds = digits(_timeLeft.inSeconds.remainder(60), 2);
    return "$oneDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return ShadowText(
      _stringTimeLeft(),
      offset: 3,
      style: TextStyle(fontSize: 30),
    );
  }
}
