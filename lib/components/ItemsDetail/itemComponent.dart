import 'package:boatusers/Models/productModel.dart';
import 'package:boatusers/components/ItemsDetail/itemColorComponent.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ItemsWidgets/itemImageWidget.dart';

class ItemComponent extends StatefulWidget {
  const ItemComponent({super.key});

  @override
  State<ItemComponent> createState() => _ItemComponentState();
}

class _ItemComponentState extends State<ItemComponent> {
  Color selectColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)?.settings.arguments) as Map<dynamic, dynamic>;
    final int buId = arguments['buItemId'];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < ProductModel.itemsData().length; i++)
                ProductModel.itemsData()[i].buItemId == buId
                    ? Expanded(
                        child: CarouselSlider(
                          items: [
                            for (int j = 0;
                                j <
                                    ProductModel.itemsData()[i]
                                        .buItemImages
                                        .length;
                                j++)
                              ItemImageWidget.ItemDetailsImageWidget(
                                  context,
                                  ProductModel.itemsData()[i].buItemImages[j],
                                  selectColor)
                          ],
                          options: CarouselOptions(
                              height: 500.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              aspectRatio: 3.0,
                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  //_current = index;
                                });
                              }),
                        ),
                      )
                    : const SizedBox.shrink(),
              ...ProductModel.itemsData().map(
                (e) => e.buItemId == buId
                    ? ItemColorComponent().itemsColors(
                        context,
                        e.buItemColors,
                        () => {
                              setState(() {
                                selectColor = ItemColorComponent.thisColor;
                              })
                            },
                        false,
                        false)
                    : const SizedBox.shrink(),
              ),
              Container(
                color: Colors.white,
                height: kIsWeb ? 30.0 : 10.0,
              ),
              //
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: const Color.fromARGB(255, 111, 57, 53),
                      child: const Icon(Icons.arrow_back),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
