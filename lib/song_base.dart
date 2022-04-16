import 'dart:convert';
import 'dart:math';

import 'models/song.dart';

class SongBase {
  final List<Song> _mainSongsList = [];
  final List<Song> _auxSongsList = [];

  bool _isUsingMainList = true;

  SongBase(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    final jsonSongs = jsonMap['songs'];

    for (final jsonSong in jsonSongs) {
      _mainSongsList.add(Song.fromMap(jsonSong));
    }

    _mainSongsList.shuffle();
  }

  Song takeSong() {
    if (_isUsingMainList) {
      final song = _mainSongsList.removeLast();
      _auxSongsList.add(song);

      if (_mainSongsList.isEmpty) {
        _isUsingMainList = false;
        _auxSongsList.shuffle();
      }

      return song;
    } else {
      final song = _auxSongsList.removeLast();
      _mainSongsList.add(song);

      if (_auxSongsList.isEmpty) {
        _isUsingMainList = true;
        _mainSongsList.shuffle();
      }

      return song;
    }
  }
}
