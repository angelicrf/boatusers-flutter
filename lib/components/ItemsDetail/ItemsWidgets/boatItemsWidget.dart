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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                padding: kIsWeb
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.all(3.0),
                child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ItemComponent(),
                                    settings: RouteSettings(arguments: {
                                      'buItemId': dataEntries[index].buItemId,
                                    })));
                              },
                              child: isSelectedColor &&
                                      dataEntries[index].buItemId ==
                                          thisClickedId
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          ItemColorComponent.thisColor ==
                                                  Colors.black
                                              ? Colors.blue
                                              : ItemColorComponent.thisColor,
                                          BlendMode.hue),
                                      child: Container(
                                          color: Colors.white,
                                          height: 250.0,
                                          width: 250.0,
                                          child: Image.network(
                                              dataEntries[index]
                                                  .buItemImages[0],
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  dataEntries[index]
                                                      .buItemImages[0]),
                                              fit: BoxFit.cover)))),
                        ),
                        const SizedBox(
                          height: kIsWeb ? 20.0 : 5.0,
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                dataEntries[index].buItemName,
                                style: const TextStyle(
                                  fontSize: kIsWeb ? 18 : 15.0,
                                  fontWeight: kIsWeb
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: kIsWeb ? 20.0 : 5.0,
                        ),
                        Container(
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '${dataEntries[index].buPrice} \$',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.deepOrange,
                                    fontWeight: kIsWeb
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ))),
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
                                },
                            false,
                            true)
                      ],
                    )),
              ),
            ));
  }
}
