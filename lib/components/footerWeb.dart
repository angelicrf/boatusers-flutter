import 'dart:ui';

import 'package:boatusers/components/userProfile.dart';
import 'package:boatusers/routes/buRouts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'boatItems.dart';
import 'favorites.dart';

class FooterWeb extends StatefulWidget {
  FooterWeb({Key? key}) : super(key: key);

  @override
  _FooterWebState createState() => _FooterWebState();
}

class _FooterWebState extends State<FooterWeb> {
  int _indexSelected = 0;
  var _controller;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Likes'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Items'),
        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile')
      ],
      currentIndex: _indexSelected,
      onTap: (index) => {print(index), navigatePages(index, context)},
      selectedItemColor: const Color.fromARGB(255, 38, 112, 205),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }

  Function(int r, BuildContext context) navigatePages =
      (int r, BuildContext context) {
    switch (r) {
      case 0:
        Navigator.pushNamed(context, BuRouts.BUHome);
        break;
      case 1:
        Navigator.pushNamed(context, BuRouts.BUFavorites);

        break;
      case 2:
        Navigator.pushNamed(context, BuRouts.BUItems);
        break;
      case 3:
        Navigator.pushNamed(context, BuRouts.BUserProfile);
        break;
    }
  };
}
