import 'package:boatusers/components/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../routes/buRouts.dart';
import 'boatItems.dart';
import 'favorites.dart';

class FooterMB extends StatefulWidget {
  @override
  _FooterMBState createState() => _FooterMBState();
}

class _FooterMBState extends State<FooterMB> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.star,
              text: 'Likes',
            ),
            GButton(
              icon: Icons.shopping_bag,
              text: 'Items',
            ),
            GButton(
              icon: Icons.account_box,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            print(index);
            setState(() {
              _selectedIndex = index;
            });
            navigatePages(index, context);
          },
        ),
        //
      ),
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
