import 'package:flutter_xkcd/data/api.dart';
import 'package:flutter_xkcd/data/database.dart';
import 'package:flutter_xkcd/models/comic.dart';

/// Repository class that handles fetching data from both network and remote sources.
class XKCDRepository {
  final XKCDDatabase database;
  final XKCDApi api;

  XKCDRepository({
    this.database,
    this.api,
  });

  /// For the latest comic, we always want to fetch from the API. We still add
  /// this to our local storage though, so the user will see it next time they
  /// scroll to that page.
  Future<Comic> fetchLatestComic() async {
    final comic = await api.fetchLatestComic();
    await database.newComic(comic);
    return comic;
  }

  /// When fetching for a specific comic, we first check if it exists in local
  /// storage. If it doesn't, we will go to the remote server.
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
