import 'dart:convert';

class Song {
  final String title;
  final String artist;
  Song({
    this.title,
    this.artist,
  });

  Song copyWith({
    String title,
    String artist,
  }) {
    return Song(
      title: title ?? this.title,
      artist: artist ?? this.artist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Song(
      title: map['title'],
      artist: map['artist'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() => 'Song(title: $title, artist: $artist)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Song && o.title == title && o.artist == artist;
  }

  @override
  int get hashCode => title.hashCode ^ artist.hashCode;
}
