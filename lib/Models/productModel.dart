import 'package:flutter/material.dart';

class ProductModel {
  final int buItemId;
  final String buItemName;
  final String buDescription;
  final String buPrice;
  final bool buIsItemLiked;
  final List<String> buItemImages;
  final List<String> buItemReviews;
  final List<String> buItemRates;
  final List<Color> buItemColors;
  final List<String> buItemSizes;
  final List<String> buItemOptions;

  ProductModel(
      {required this.buIsItemLiked,
      required this.buItemImages,
      required this.buItemReviews,
      required this.buItemRates,
      required this.buItemColors,
      required this.buItemSizes,
      required this.buItemOptions,
      required this.buItemId,
      required this.buItemName,
      required this.buDescription,
      required this.buPrice});

  static List<ProductModel> itemsData() {
    var thisList = [
      ProductModel(
          buIsItemLiked: false,
          buItemImages: [
            'https://cdn.pixabay.com/photo/2014/04/02/10/46/circle-304524_1280.png',
            'https://cdn.pixabay.com/photo/2013/07/13/12/42/lifebelt-160144_1280.png',
            'https://cdn.pixabay.com/photo/2013/07/12/12/52/lifebelt-146420_1280.png'
          ],
          buItemReviews: [],
          buItemRates: [],
          buItemColors: [Colors.blueGrey, Colors.green, Colors.yellow],
          buItemSizes: [],
          buItemOptions: [],
          buItemId: 1,
          buItemName: 'itemOne',
          buDescription: 'itemOneDesc',
          buPrice: '95.5'),
      ProductModel(
          buIsItemLiked: false,
          buItemImages: [
            'https://cdn.pixabay.com/photo/2021/11/21/06/45/anchor-6813317_1280.png',
            'https://cdn.pixabay.com/photo/2014/04/03/09/58/anchor-309481_1280.png',
            'https://cdn.pixabay.com/photo/2016/02/28/21/22/anchor-1227607_1280.png'
          ],
          buItemReviews: [],
          buItemRates: [],
          buItemColors: [Colors.limeAccent, Colors.brown, Colors.amber],
          buItemSizes: [],
          buItemOptions: [],
          buItemId: 2,
          buItemName: 'itemTwo',
          buDescription: 'itemTwoDesc',
          buPrice: '52.41'),
      ProductModel(
          buIsItemLiked: false,
          buItemImages: [
            'https://cdn.pixabay.com/photo/2016/03/31/21/27/camera-1296434_1280.png',
            'https://cdn.pixabay.com/photo/2012/04/25/00/55/camcorder-41496_1280.png',
            'https://cdn.pixabay.com/photo/2012/04/18/12/02/camera-36840_1280.png'
          ],
          buItemReviews: [],
          buItemRates: [],
          buItemColors: [Colors.pink, Colors.purple, Colors.cyan],
          buItemSizes: [],
          buItemOptions: [],
          buItemId: 3,
          buItemName: 'itemThree',
          buDescription: 'itemThreeDesc',
          buPrice: '653.21'),
      ProductModel(
          buIsItemLiked: false,
          buItemImages: [
            'https://cdn.pixabay.com/photo/2012/04/24/23/27/usb-41108_1280.png',
            'https://cdn.pixabay.com/photo/2014/04/02/10/35/usb-stick-303942_1280.png',
            'https://cdn.pixabay.com/photo/2013/07/12/18/17/flash-drive-153204_1280.png'
          ],
          buItemReviews: [],
          buItemRates: [],
          buItemColors: [Colors.red, Colors.lightBlue, Colors.lightGreen],
          buItemSizes: [],
          buItemOptions: [],
          buItemId: 4,
          buItemName: 'itemFour',
          buDescription: 'itemFourDesc',
          buPrice: '412.52'),
    ];
    return thisList;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        buIsItemLiked: json['buIsItemLiked'],
        buItemImages: json['buItemImages'],
        buItemReviews: json['buItemReviews'],
        buItemRates: json['buItemRates'],
        buItemColors: json['buItemColors'],
        buItemSizes: json['buItemSizes'],
        buItemOptions: json['buItemOptions'],
        buItemId: json['buItemId'],
        buItemName: json['buItemName'],
        buDescription: json['buDescription'],
        buPrice: json['buPrice']);
  }
}
