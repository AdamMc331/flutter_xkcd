import 'package:flutter/material.dart';
import 'package:flutter_xkcd/models/comic.dart' as model;
import 'package:flutter_xkcd/widgets/zoomable_image_page.dart';

/// Widget that displays a particular comic.
class Comic extends StatefulWidget {
  final model.Comic comic;

  Comic({
    this.comic,
  });

  @override
  _ComicState createState() => _ComicState();
}

class _ComicState extends State<Comic> {
  String _getTitle() {
    return '${widget.comic.title} - #${widget.comic.number}';
  }

  void _imageTapped() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ZoomableImagePage(imageUrl: widget.comic.image)));
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
            child: GestureDetector(
              child: Image.network(widget.comic.image),
              onTap: _imageTapped,
            ),
          ),
          Text(widget.comic.altText),
        ],
      ),
    );
  }
}
