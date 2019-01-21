import 'package:flutter/material.dart';
import 'package:flutter_xkcd/data/repository.dart';
import 'package:flutter_xkcd/models/comic.dart';
import 'package:flutter_xkcd/widgets/comic.dart' as comicWidget;

/// A page that displays a comic, and is also responsible for fetching that
/// comic from our [repository].
class ComicPage extends StatelessWidget {
  final XKCDRepository repository;
  final int comicNumber;

  ComicPage({
    this.repository,
    this.comicNumber,
  });

  Future<Comic> _getFuture() {
    return comicNumber == null
        ? repository.fetchLatestComic()
        : repository.fetchComic(comicNumber);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Comic>(
      future: _getFuture(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return comicWidget.Comic(comic: snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
