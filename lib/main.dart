import 'dart:math';

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
  final _repository = XKCDRepository(
    api: XKCDApi(),
    database: XKCDDatabase.db,
  );

  /// We want the page controller to be defined at the class level so we can
  /// tell it to move to a certain page.
  final _pageController = PageController(
    initialPage: 0,
  );

  /// The number of comics based on our call to get the latest.
  int _comicCount = 0;

  bool _isSearching = false;

  void _onRandomPressed() {
    _pageController.jumpToPage(Random().nextInt(_comicCount));
  }

  static final String _jumpToLatest = "Jump To Latest";
  static final String _search = "Search";

  static final _choices = [_jumpToLatest, _search];

  void _onActionItemSelected(String item) {
    if (item == _jumpToLatest) {
      _pageController.jumpToPage(0);
    } else if (item == _search) {
      setState(() {
        _isSearching = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching ? _buildSearchingAppBar() : _buildDefaultAppBar(),
      body: SafeArea(
        child: _buildComicPager(),
      ),
    );
  }

  /// Builds the app bar to use when we're not actively searching.
  Widget _buildDefaultAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        _buildRandomAction(),
        _buildPopupMenu(),
      ],
    );
  }

  /// Builds the appbar that should appear when we are searching.
  Widget _buildSearchingAppBar() {
    return AppBar(
      title: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search, color: Colors.white),
          hintText: "Search...",
          hintStyle: new TextStyle(color: Colors.white),
        ),
        keyboardType: TextInputType.number,
        autofocus: true,
        onSubmitted: (input) {
          setState(() {
            _isSearching = false;
            _loadComic(input);
          });
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _isSearching = false;
            });
          },
        )
      ],
    );
  }

  /// Builds the popup menu of overflow choices.
  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      onSelected: _onActionItemSelected,
      itemBuilder: (BuildContext context) {
        return _choices.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList();
      },
    );
  }

  /// Builds the action widget for the random icon.
  Widget _buildRandomAction() {
    return GestureDetector(
      onTap: _onRandomPressed,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('RANDOM'),
        ),
      ),
    );
  }

  /// Builds a page view that first fetches the latest comic to get the
  /// comic number, and then paginates through them.
  Widget _buildComicPager() {
    return FutureBuilder<Comic>(
      future: _repository.fetchLatestComic(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _comicCount = snapshot.data.number;

          return PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return ComicPage(
                repository: _repository,
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

  void _loadComic(String input) {
    final comicNumber = int.parse(input);
    final page = _comicCount - comicNumber;
    _pageController.jumpToPage(page);
  }
}
