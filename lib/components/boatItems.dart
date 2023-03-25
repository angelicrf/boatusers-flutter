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
        resizeToAvoidBottomInset: false,
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
        body:
            //Row(children: <Widget>[
            // Flexible(
            //child:
            displayCatalog(context, dataEntries));
    //]));
  }

  Widget displayCatalog(BuildContext context, List<ProductModel> dataEntries) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kIsWeb ? 2 : 1,
          //mainAxisSpacing: 5,
          //crossAxisSpacing: 5,
          mainAxisExtent: kIsWeb ? 600.0 : 450.0,
        ),
        itemCount: dataEntries.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) => Center(
                child: Container(
              width: kIsWeb ? 350.0 : 280.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 211, 171, 171)),
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: isSelectedColor &&
                            dataEntries[index].buItemId == thisClickedId
                        ? ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(colors: [
                                globals.ItemColorComponent.thisColor ==
                                        Colors.black
                                    ? Colors.blue
                                    : globals.ItemColorComponent.thisColor,
                                globals.ItemColorComponent.thisColor ==
                                        Colors.black
                                    ? Colors.green
                                    : globals.ItemColorComponent.thisColor,
                              ]).createShader(bounds);
                            },
                            blendMode: BlendMode.colorBurn,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  dataEntries[index].buItemImages[0],
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Text(
                                        'not displayed ${exception.toString()}');
                                  },
                                )),
                          )
                        : isSelectedColor &&
                                dataEntries[index].buItemId != thisClickedId
                            ? Image.network(
                                dataEntries[index].buItemImages[0],
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text(
                                      'not displayed ${exception.toString()}');
                                },
                              )
                            : Image.network(
                                dataEntries[index].buItemImages[0],
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text(
                                      'not displayed ${exception.toString()}');
                                },
                              ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Item: ${dataEntries[index].buItemName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Price: ${dataEntries[index].buPrice} \$',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
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
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            dataEntries[index].buDescription,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )),
                    ],
                  ),
                ],
              )),
            )));
  }
}
