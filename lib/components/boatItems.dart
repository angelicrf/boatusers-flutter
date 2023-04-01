import 'package:boatusers/components/ItemsDetail/ItemsWidgets/itemListHorizantal.dart';
import 'package:boatusers/components/searchWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Models/productModel.dart';
import 'ItemsDetail/ItemsWidgets/boatItemsWidget.dart';

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
  bool isSelectedHColor = false;
  int thisClickedHId = 0;

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
      body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ItemListHorizantal.displayItemsListHorizantal(
              context,
              dataEntries,
              isSelectedHColor,
              thisClickedHId,
              () => {
                    setState(
                      () {
                        print(dataEntries[ItemListHorizantal.thisLHIndex]
                            .buItemId);
                        thisClickedHId =
                            dataEntries[ItemListHorizantal.thisLHIndex]
                                .buItemId;
                        isSelectedHColor = true;
                      },
                    )
                  }),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 224, 248, 242),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BoatItemsWidget.displayCatalog(
                        context,
                        dataEntries,
                        isSelectedColor,
                        thisClickedId,
                        () => {
                              setState(
                                () {
                                  print(dataEntries[BoatItemsWidget.thisIndex]
                                      .buItemId);
                                  thisClickedId =
                                      dataEntries[BoatItemsWidget.thisIndex]
                                          .buItemId;
                                  isSelectedColor = true;
                                },
                              )
                            }),
                  ],
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 224, 248, 242),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: const [Text('data')],
            )
          ],
        )
      ]),
    );
  }
}
