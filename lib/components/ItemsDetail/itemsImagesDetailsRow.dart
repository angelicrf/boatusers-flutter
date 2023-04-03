import 'package:boatusers/Models/productModel.dart';
import 'package:flutter/material.dart';

class ItemImagesDEtailsRow {
  static Widget displayImgaesColumn() {
    return Column(
      children: [
        ...ProductModel.itemsData().map((e) => SizedBox(
              width: 50.0,
              height: 50.0,
              child: Image.network(e.buItemImages[0]),
            ))
      ],
    );
  }
}
