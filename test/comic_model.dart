import 'dart:convert';

import 'package:flutter_xkcd/models/comic.dart';
import 'package:test/test.dart';

import 'mocks/mock_comic.dart';

void main() {
  group('Comic Test', () {
    test('can deserialize comic', () {
      final comicJson = json.decode(mockComic);
      final comic = Comic.fromJson(comicJson);

      expect("7", comic.month);
      expect(614, comic.number);
      expect("", comic.link);
      expect("2009", comic.year);
      expect("", comic.news);
      expect("Woodpecker", comic.safeTitle);
      expect("Test transcript", comic.transcript);
      expect("Test alt", comic.altText);
      expect("https://imgs.xkcd.com/comics/woodpecker.png", comic.image);
      expect("Woodpecker", comic.title);
      expect("24", comic.day);
    });

    test('can serialize comic', () {
      final comicJson = json.decode(mockComic);
      final originalComic = Comic.fromJson(comicJson);

      final newComicJson = originalComic.toJson();
      final newComic = Comic.fromJson(newComicJson);

      expect(originalComic, newComic);
    });
  });
}
