import 'package:flutter/material.dart';
import 'package:zoomable_image/zoomable_image.dart';

/// Special page that shows an image and allows you to zoom in on it.
class ZoomableImagePage extends StatelessWidget {
  final String imageUrl;

  ZoomableImagePage({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          ZoomableImage(
            NetworkImage(imageUrl),
          ),
          _buildBackButton(context),
        ],
      ),
    );
  }

  /// Builds a button that allows the user to navigate back to the last screen.
  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
