import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        height: 144.0,
        child: Text('Favorites Page'),
      ),
    );
  }
}
