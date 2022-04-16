import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_czolko/models/song.dart';
import 'package:my_czolko/song_base.dart';
import 'package:my_czolko/widgets/animated_opacity_widget.dart';
import 'package:my_czolko/widgets/song_screen.dart';

class GameScreen extends StatefulWidget {
  final SongBase songs;

  const GameScreen(this.songs);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const PurpleColor = Color.fromRGBO(226, 101, 239, 1);
  // static const GreenColor = Color.fromRGBO(85, 195, 60, 1);
  static final GreenColor = Colors.green[600];
  static const RedColor = Color.fromRGBO(240, 64, 51, 1);
  var _color = PurpleColor;
  Widget _content;

  int _songsCounter = 1;

  @override
  void initState() {
    super.initState();

    _content = SongScreen(_getSong(), _onTimerExpired);
  }

  void _onTimerExpired() {
    setState(() {
      _color = RedColor;
      _content = Center(
        child: AnimatedOpacityWidget(
          Text(
            'CZAS MINĄŁ',
            style: TextStyle(fontSize: 90),
          ),
        ),
      );
    });
  }

  void _handleTap(TapUpDetails details) {
    if (_color != PurpleColor) {
      setState(() {
        _color = PurpleColor;
        _content = SongScreen(_getSong(), _onTimerExpired);
      });
      return;
    }

    Color color;
    String text;

    final tapXposition = details.globalPosition.dx;
    if (tapXposition > MediaQuery.of(context).size.width / 2) {
      color = GreenColor;
      text = 'DOBRZE!';
    } else {
      color = RedColor;
      text = 'PASUJĘ';
    }

    _songsCounter++;

    if (_songsCounter > 10) {
      color = Colors.blue[700];
      text = 'KONIEC!';
      _songsCounter = 1;
    }

    setState(() {
      _color = color;
      _content = Center(
        child: AnimatedOpacityWidget(
          Text(
            text,
            style: TextStyle(fontSize: 90),
          ),
        ),
      );
    });
  }

  Song _getSong() {
    return widget.songs.takeSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: _handleTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _color,
            border: Border.all(
              color: Colors.white,
              width: 15,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: _content,
        ),
      ),
    );
  }
}
