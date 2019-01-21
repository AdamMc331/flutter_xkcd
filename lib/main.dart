import 'package:flutter/material.dart';
import 'package:flutter_xkcd/data/api.dart';
import 'package:flutter_xkcd/data/database.dart';
import 'package:flutter_xkcd/data/repository.dart';
import 'package:flutter_xkcd/models/comic.dart';
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
  XKCDRepository _getRepository() {
    return XKCDRepository(
      api: XKCDApi(),
      database: XKCDDatabase.db,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _buildComicPager(),
      ),
    );
  }

  /// Builds a page view that first fetches the latest comic to get the
  /// comic number, and then paginates through them.
  Widget _buildComicPager() {
    return FutureBuilder<Comic>(
        future: _getRepository().fetchLatestComic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
              controller: PageController(
                initialPage: 0,
              ),
              itemBuilder: (context, index) {
                return ComicPage(
                  repository: _getRepository(),
                  comicNumber: snapshot.data.number - index,
                );
              },
              itemCount: snapshot.data.number,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }
}
