import 'package:boatusers/components/searchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: kIsWeb ? 220.0 : 50.0,
          child: Text(
            kIsWeb ? 'User Favorites' : 'Favorites',
            style: TextStyle(
              fontSize: kIsWeb ? 18.0 : 12.0,
            ),
          ),
        ),
        actions: [
          SearchWidget.searchTextField(searchController),
          SizedBox(
              child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    print(searchController.text);
                  }))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        height: 144.0,
        child: const Text('Favorites Page'),
      ),
    );
  }
}
