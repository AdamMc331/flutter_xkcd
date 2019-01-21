import 'dart:convert';

import 'package:flutter_xkcd/models/comic.dart';
import 'package:http/http.dart' as http;

/// Class responsible for fetching comic data from the server.
class XKCDApi {
  /// Retrieves the current comic.
  Future<Comic> fetchLatestComic() async {
    final response = await http.get('https://xkcd.com/info.0.json');

    print("Fetching latest comic from server.");

    if (response.statusCode == 200) {
      return Comic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load latest comic.');
    }
  }

  /// Retrieves a comic with a specific [comicNumber].
  Future<Comic> fetchComic(int comicNumber) async {
    final response = await http.get('https://xkcd.com/$comicNumber/info.0.json');

    print("Fetching comic $comicNumber from server.");

    if (response.statusCode == 200) {
      return Comic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load comic $comicNumber.');
    }
  }
}