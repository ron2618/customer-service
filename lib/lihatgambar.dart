import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Lihat extends StatefulWidget {
  final String url;

  const Lihat({Key key, this.url}) : super(key: key);
  @override
  _LihatState createState() => _LihatState();
}

class _LihatState extends State<Lihat> {
  @override
  Widget build(BuildContext context) {
   return Container(
    child: PhotoView(
      imageProvider: NetworkImage(widget.url),
    )
  );
  }
}