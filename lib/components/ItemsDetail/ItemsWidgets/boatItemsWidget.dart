import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Models/productModel.dart';
import '../itemColorComponent.dart';
import '../itemComponent.dart';

class BoatItemsWidget {
  static int thisIndex = 0;
  static Widget displayCatalog(
      BuildContext context,
      List<ProductModel> dataEntries,
      bool isSelectedColor,
      int thisClickedId,
      void Function() displaySetState) {
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
                                            ItemColorComponent.thisColor ==
                                                    Colors.black
                                                ? Colors.blue
                                                : ItemColorComponent.thisColor,
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
                  ItemColorComponent().itemsColors(
                      context,
                      dataEntries[index].buItemColors,
                      () => {
                            print(thisIndex),
                            thisIndex = index,
                            displaySetState(),
                            print(thisIndex),
                          }),
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
