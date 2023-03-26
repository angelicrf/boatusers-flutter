import 'package:boatusers/components/ItemsDetail/ItemsWidgets/boatItemsWidget.dart';
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
          child: BoatItemsWidget.displayCatalog(
              context,
              dataEntries,
              isSelectedColor,
              thisClickedId,
              () => {
                    setState(
                      () {
                        print(dataEntries[BoatItemsWidget.thisIndex].buItemId);
                        thisClickedId =
                            dataEntries[BoatItemsWidget.thisIndex].buItemId;
                        isSelectedColor = true;
                      },
                    )
                  }),
        ));
    //]));
  }
}
