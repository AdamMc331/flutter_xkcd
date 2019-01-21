import 'package:flutter/material.dart';
import 'package:zoomable_image/zoomable_image.dart';

class ZoomableImagePage extends StatelessWidget {
  final String imageUrl;

  ZoomableImagePage({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZoomableImage(
        NetworkImage(imageUrl),
      ),
    );
  }
}
