import 'package:flutter/material.dart';
import 'package:flutter_xkcd/data/api.dart';
import 'package:flutter_xkcd/models/comic.dart';
import 'package:flutter_xkcd/widgets/comic.dart' as comicWidget;

class ComicPage extends StatelessWidget {
  final XKCDApi api;
  final int comicNumber;

  ComicPage({
    this.api,
    this.comicNumber,
  });

  Future<Comic> _getFuture() {
    return comicNumber == null
        ? api.fetchLatestComic()
        : api.fetchComic(comicNumber);
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
