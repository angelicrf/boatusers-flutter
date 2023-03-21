class ProductModel {
  final int buItemId;
  final String buItemName;
  final String buDescription;
  final String buPrice;

  ProductModel(
      {required this.buItemId,
      required this.buItemName,
      required this.buDescription,
      required this.buPrice});

  static List<ProductModel> itemsData() {
    var thisList = [
      ProductModel(
          buItemId: 1,
          buItemName: 'itemOne',
          buDescription: 'itemOneDesc',
          buPrice: '95.5'),
      ProductModel(
          buItemId: 2,
          buItemName: 'itemTwo',
          buDescription: 'itemTwoDesc',
          buPrice: '52.41'),
      ProductModel(
          buItemId: 3,
          buItemName: 'itemThree',
          buDescription: 'itemThreeDesc',
          buPrice: '653.21'),
      ProductModel(
          buItemId: 4,
          buItemName: 'itemFour',
          buDescription: 'itemFourDesc',
          buPrice: '412.52'),
    ];
    return thisList;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        buItemId: json['buItemId'],
        buItemName: json['buItemName'],
        buDescription: json['buDescription'],
        buPrice: json['buPrice']);
  }
}
