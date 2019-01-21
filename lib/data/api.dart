import 'dart:convert';

import 'package:flutter_xkcd/models/comic.dart';
import 'package:http/http.dart' as http;

class XKCDApi {
  Future<Comic> fetchLatestComic() async {
    final response = await http.get('https://xkcd.com/info.0.json');

    if (response.statusCode == 200) {
      return Comic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load latest comic.');
    }
  }
}