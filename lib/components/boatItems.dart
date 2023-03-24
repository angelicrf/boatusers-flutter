import 'package:boatusers/components/ItemsDetail/itemColorComponent.dart'
    as globals;
import 'package:boatusers/components/searchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Models/productModel.dart';

class BoatItems extends StatefulWidget {
  const BoatItems({Key? key}) : super(key: key);

  @override
  _BoatItemsState createState() => _BoatItemsState();
}

class _BoatItemsState extends State<BoatItems> {
  final searchController = TextEditingController();
  final dataEntries = ProductModel.itemsData();
  bool isSelectedColor = false;
  int thisClickedId = 0;

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
              kIsWeb ? 'Boat Items' : 'Items',
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: displayCatalog(context, dataEntries),
        ));
  }

  Widget displayCatalog(BuildContext context, List<ProductModel> dataEntries) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: dataEntries.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) => Card(
                child: Container(
              width: 400,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child:
                  //Stack(
                  //children: [
                  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: isSelectedColor &&
                            dataEntries[index].buItemId == thisClickedId
                        ? ShaderMask(
                            shaderCallback: (bounds) {
                              return RadialGradient(colors: [
                                globals.ItemColorComponent.thisColor ==
                                        Colors.black
                                    ? Colors.blue
                                    : globals.ItemColorComponent.thisColor,
                                globals.ItemColorComponent.thisColor ==
                                        Colors.black
                                    ? Colors.green
                                    : globals.ItemColorComponent.thisColor,
                                Colors.grey
                              ]).createShader(bounds);
                            },
                            blendMode: BlendMode.colorBurn,
                            child: Image.network(
                              //'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              dataEntries[index].buItemImages[0],
                              width: 420,
                              height: 340,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Text(
                                    'not displayed ${exception.toString()}');
                              },
                            ),
                          )
                        //Text('isSelected ${dataEntries[index].buItemId}')

                        : isSelectedColor &&
                                dataEntries[index].buItemId != thisClickedId
                            ? Image.network(
                                dataEntries[index].buItemImages[0],
                                width: 60,
                                height: 40,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text(
                                      'not displayed ${exception.toString()}');
                                },
                              )
                            //Text('notSelected ${dataEntries[index].buItemId}')
                            : Image.network(
                                dataEntries[index].buItemImages[0],
                                width: 420,
                                height: 340,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text(
                                      'not displayed ${exception.toString()}');
                                },
                              ),
                  ),
                  Text(globals.ItemColorComponent.thisColor.value.toString()),
                  Text(
                    'Item: ${dataEntries[index].buItemName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: ${dataEntries[index].buPrice}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  globals.ItemColorComponent().itemsColors(
                      context,
                      dataEntries[index].buItemColors,
                      () => setState(() {
                            print(dataEntries[index].buItemId);
                            thisClickedId = dataEntries[index].buItemId;
                            isSelectedColor = true;
                          })),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        dataEntries[index].buDescription,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
