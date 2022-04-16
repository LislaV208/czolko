import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_czolko/screens/game_screen.dart';
import 'package:my_czolko/song_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Muzyczne Czółko',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontFamily: 'TitilliumWeb',
              color: Colors.white,
              height: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withAlpha(69),
                  offset: Offset(0, 7),
                ),
              ],
            ),
          ),
        ),
        home: FutureBuilder<String>(
          future: rootBundle.loadString('assets/data/songs.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final songBase = SongBase(snapshot.data);
              return GameScreen(songBase);
            } else {
              return Scaffold();
            }
          },
        )
        // GameScreen(),
        );
  }
}
