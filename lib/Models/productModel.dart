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
            'https://cdn.pixabay.com/photo/2016/04/01/08/30/bag-1298763_1280.png',
            // 'https://images.pexels.com/photos/7412073/pexels-photo-7412073.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/1639729/pexels-photo-1639729.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/6345208/pexels-photo-6345208.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
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
            'https://www.freepnglogos.com/uploads/headphones-png/headphones-transparent-png-pictures-icons-and-png-26.png',
            'https://www.freepnglogos.com/uploads/anchor-png/images-for-anchor-png-cliparts-39.png',
            //'https://www.freepnglogos.com/uploads/shoes-png/download-running-shoes-png-image-png-image-pngimg-4.png',
            //'https://www.freepnglogos.com/uploads/shoes-png/download-adidas-shoes-transparent-png-images-icons-18.png',
            'https://www.freepnglogos.com/uploads/shopping-bag-png/shopping-bag-business-icons-22.png',
            'https://images.pexels.com/photos/4210337/pexels-photo-4210337.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
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
            'https://images.pexels.com/photos/13610995/pexels-photo-13610995.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/14121604/pexels-photo-14121604.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/14036608/pexels-photo-14036608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
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
            'https://images.pexels.com/photos/4239014/pexels-photo-4239014.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/15848006/pexels-photo-15848006.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            'https://images.pexels.com/photos/15925462/pexels-photo-15925462.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
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
