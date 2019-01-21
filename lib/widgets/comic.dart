import 'package:flutter/material.dart';
import 'package:flutter_xkcd/models/comic.dart' as model;

class Comic extends StatelessWidget {
  final model.Comic comic;

  Comic({
    this.comic,
  });

  String _getTitle() {
    return '${comic.title} - #${comic.number}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _getTitle(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Image.network(comic.image),
          ),
          Text(comic.altText),
        ],
      ),
    );
  }
}
