import 'package:flutter/material.dart';
import 'package:flutter_xkcd/data/api.dart';
import 'package:flutter_xkcd/widgets/comic_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'XKCD Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(
            initialPage: 0,
          ),
          itemBuilder: (context, index) {
            return ComicPage(
              api: XKCDApi(),
              comicNumber: 2100 - index,
            );
          },
          itemCount: 2100,
        ),
      ),
    );
  }
}
