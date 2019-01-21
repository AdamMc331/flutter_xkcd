import 'package:flutter_xkcd/data/api.dart';
import 'package:flutter_xkcd/data/database.dart';
import 'package:flutter_xkcd/models/comic.dart';

class XKCDRepository {
  final XKCDDatabase database;
  final XKCDApi api;

  XKCDRepository({
    this.database,
    this.api,
  });

  Future<Comic> fetchLatestComic() async {
    final comic = await api.fetchLatestComic();
    await database.newComic(comic);
    return comic;
  }

  Future<Comic> fetchComic(int comicNumber) async {
    final cachedComic = await database.getComic(comicNumber);

    if (cachedComic != Null) {
      print("Fetching comic $comicNumber from database.");
      return cachedComic;
    } else {
      final remoteComic = await api.fetchComic(comicNumber);
      await database.newComic(remoteComic);
      return remoteComic;
    }
  }
}
