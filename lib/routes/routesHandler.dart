import 'package:boatusers/components/boatItems.dart';
import 'package:boatusers/components/favorites.dart';
import 'package:boatusers/components/profileUserUpdateForm.dart';
import 'package:boatusers/components/userProfile.dart';
import 'package:boatusers/main.dart';
import 'package:boatusers/routes/buRouts.dart';
import 'package:flutter/material.dart';

Route<dynamic> handleRoutes(RouteSettings thisSettings) {
  switch (thisSettings.name) {
    case BuRouts.BUHome:
      return _getPageRoute(
          thisSettings.name!, BUHomePage('Boat Users App', UniqueKey()));
    case BuRouts.BUFavorites:
      return _getPageRoute(thisSettings.name!, Favorites());
    case BuRouts.BUItems:
      return _getPageRoute(thisSettings.name!, BoatItems());
    case BuRouts.BUserProfile:
      return _getPageRoute(thisSettings.name!, UserProfile());
    //case BuRouts.BUserProfileUpdate:
    // return _getPageRoute(thisSettings.name!, ProfileUserUpdateForm());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Text(''),
              ));
  }
}

Route<dynamic> _getPageRoute(String routeName, Widget screen) {
  return MaterialPageRoute(
      builder: (context) => screen, settings: RouteSettings(name: routeName));
}
