import 'package:boatusers/components/ItemsDetail/itemColorComponent.dart'
    as globals;
import 'package:boatusers/components/ItemsDetail/itemComponent.dart';
import 'package:boatusers/components/searchWidget.dart';
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

            Padding(
          padding: const EdgeInsets.all(18.0),
          child: displayCatalog(context, dataEntries),
        ));
    //]));
  }

  Widget displayCatalog(BuildContext context, List<ProductModel> dataEntries) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          mainAxisExtent: kIsWeb ? 600.0 : 280.0,
        ),
        itemCount: dataEntries.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) => Center(
                child: Container(
              width: kIsWeb ? 350.0 : 200.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(255, 211, 171, 171)),
              padding: kIsWeb
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.all(3.0),
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: isSelectedColor &&
                            dataEntries[index].buItemId == thisClickedId
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ItemComponent(),
                                  settings: RouteSettings(arguments: {
                                    'buItemId': dataEntries[index].buItemId,
                                  })));
                            },
                            child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            dataEntries[index].buItemImages[0]),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            globals.ItemColorComponent
                                                        .thisColor ==
                                                    Colors.black
                                                ? Colors.blue
                                                : globals.ItemColorComponent
                                                    .thisColor,
                                            BlendMode.color))),
                                child: const SizedBox()))
                        : isSelectedColor &&
                                dataEntries[index].buItemId != thisClickedId
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ItemComponent(),
                                      settings: RouteSettings(arguments: {
                                        'buItemId': dataEntries[index].buItemId,
                                      })));
                                },
                                child: Image.network(
                                  dataEntries[index].buItemImages[0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Text(
                                        'not displayed ${exception.toString()}');
                                  },
                                ))
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ItemComponent(),
                                      settings: RouteSettings(arguments: {
                                        'buItemId': dataEntries[index].buItemId,
                                      })));
                                },
                                child: Image.network(
                                  dataEntries[index].buItemImages[0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Text(
                                        'not displayed ${exception.toString()}');
                                  },
                                )),
                  ),
                  const SizedBox(
                    height: kIsWeb ? 20.0 : 5.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        dataEntries[index].buItemName,
                        style: const TextStyle(
                          fontSize: kIsWeb ? 18 : 15.0,
                          fontWeight:
                              kIsWeb ? FontWeight.bold : FontWeight.normal,
                        ),
                      )),
                  const SizedBox(
                    height: kIsWeb ? 20.0 : 5.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${dataEntries[index].buPrice} \$',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.deepOrange,
                          fontWeight:
                              kIsWeb ? FontWeight.bold : FontWeight.normal,
                        ),
                      )),
                  const SizedBox(
                    height: kIsWeb ? 20.0 : 5.0,
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
                    height: 5.0,
                  )
                  /*         Row(
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
                  ), */
                ],
              )),
            )));
  }
}
