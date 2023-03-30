import 'package:boatusers/Models/productModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ItemsWidgets/itemImageWidget.dart';
import 'itemColorComponent.dart';

class ItemComponent extends StatefulWidget {
  const ItemComponent({super.key});

  @override
  State<ItemComponent> createState() => _ItemComponentState();
}

class _ItemComponentState extends State<ItemComponent> {
  Color selectColor = Colors.black;
  final PageController pController = PageController();
  @override
  void dispose() {
    pController.dispose();
    super.dispose();
  }

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
                    ? !kIsWeb
                        ? CarouselSlider(
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
                                    selectColor),
                            ],
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                autoPlayInterval: const Duration(seconds: 9),
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {});
                                }),
                            // ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: PageView(
                              // controller to set color from each swipe from grey to selectColor
                              controller: pController,
                              children: [
                                for (int j = 0;
                                    j <
                                        ProductModel.itemsData()[i]
                                            .buItemImages
                                            .length;
                                    j++)
                                  ItemImageWebWidget.itemDetailsWebImageWidget(
                                      context,
                                      ProductModel.itemsData()[i]
                                          .buItemImages[j],
                                      selectColor)
                              ],
                            ))
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
