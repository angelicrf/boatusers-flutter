import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Models/productModel.dart';
import '../itemColorComponent.dart';
import '../itemComponent.dart';

class ItemListHorizantal {
  static int thisLHIndex = 0;
  static Widget displayItemsListHorizantal(
      BuildContext context,
      List<ProductModel> dataEntries,
      bool isSelectedColor,
      int thisClickedId,
      void Function() displaySetState) {
    return Center(
        child: SizedBox(
            height: 160.0,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  mainAxisExtent: kIsWeb ? 600.0 : 290.0,
                ),
                itemCount: dataEntries.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color.fromARGB(255, 230, 225, 234)),
                      padding: kIsWeb
                          ? const EdgeInsets.all(8.0)
                          : const EdgeInsets.all(3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            //flex: 1,
                            child: isSelectedColor &&
                                    dataEntries[index].buItemId == thisClickedId
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ItemComponent(),
                                              settings:
                                                  RouteSettings(arguments: {
                                                'buItemId':
                                                    dataEntries[index].buItemId,
                                              })));
                                    },
                                    child: Container(
                                        height: 140.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    dataEntries[index]
                                                        .buItemImages[0]),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    ItemColorComponent
                                                                .thisColor ==
                                                            Colors.black
                                                        ? Colors.blue
                                                        : ItemColorComponent
                                                            .thisColor,
                                                    BlendMode.color))),
                                        child: const SizedBox()))
                                : isSelectedColor &&
                                        dataEntries[index].buItemId !=
                                            thisClickedId
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ItemComponent(),
                                                  settings:
                                                      RouteSettings(arguments: {
                                                    'buItemId':
                                                        dataEntries[index]
                                                            .buItemId,
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ItemComponent(),
                                                  settings:
                                                      RouteSettings(arguments: {
                                                    'buItemId':
                                                        dataEntries[index]
                                                            .buItemId,
                                                  })));
                                        },
                                        child: Center(
                                            child: Container(
                                                height: 140.0,
                                                width: 120.0,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          dataEntries[index]
                                                              .buItemImages[0]),
                                                      fit: BoxFit.cover,
                                                    )),
                                                child: const SizedBox()))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
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
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '${dataEntries[index].buPrice} \$',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold),
                                  )),
                              ItemColorComponent().itemsColors(
                                  context,
                                  dataEntries[index].buItemColors,
                                  () => {
                                        print(thisLHIndex),
                                        thisLHIndex = index,
                                        displaySetState(),
                                        print(thisLHIndex),
                                      }),
                            ],
                          ),

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
                      ),
                    ))));
  }
}
