import 'dart:async';

import 'package:boatusers/Models/productModel.dart';
import 'package:boatusers/components/thumbDownItem.dart';
import 'package:boatusers/components/thumbUpItem.dart';
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
  final PageController pController = PageController(initialPage: 0);
  bool isColorChanged = false;
  bool isImageHovered = false;
  int hoveredImageIndex = 0;
  bool isThumbsUpClicked = false;
  bool isThumbsDownClicked = false;

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
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < ProductModel.itemsData().length; i++)
                ProductModel.itemsData()[i].buItemId == buId
                    ? !kIsWeb
                        ? Column(
                            children: [
                              CarouselSlider(
                                items: [
                                  for (int j = 0;
                                      j <
                                          ProductModel.itemsData()[i]
                                              .buItemImages
                                              .length;
                                      j++)
                                    ItemImageWidget.ItemDetailsImageWidget(
                                        context,
                                        ProductModel.itemsData()[i]
                                            .buItemImages[j],
                                        selectColor),
                                ],
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 9),
                                    autoPlay: true,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.zoom,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {});
                                    }),
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ItemColorComponent().itemsColors(
                                    context,
                                    ProductModel.itemsData()[i].buItemColors,
                                    () => {
                                          setState(() {
                                            selectColor =
                                                ItemColorComponent.thisColor;
                                          })
                                        },
                                    true,
                                    false),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 111, 57, 53),
                                          child: const Icon(Icons.arrow_back),
                                        ),
                                      ),
                                      IconButton(
                                          color: isThumbsUpClicked &&
                                                  !isThumbsDownClicked
                                              ? Colors.red
                                              : null,
                                          onPressed: () {
                                            setState(() {
                                              isThumbsDownClicked = false;
                                              isThumbsUpClicked = true;
                                            });
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ThumUpItem(),
                                                    settings: RouteSettings(
                                                        arguments: {
                                                          'buThumbUpItemId':
                                                              ProductModel
                                                                      .itemsData()[i]
                                                                  .buItemId,
                                                        })));
                                          },
                                          icon: const Icon(
                                            Icons.thumb_up_off_alt_sharp,
                                            size: 30.0,
                                          )),
                                      IconButton(
                                          color: !isThumbsUpClicked &&
                                                  isThumbsDownClicked
                                              ? Colors.grey
                                              : null,
                                          onPressed: () {
                                            setState(() {
                                              isThumbsUpClicked = false;
                                              isThumbsDownClicked = true;
                                            });
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ThumbDownItem(),
                                                    settings: RouteSettings(
                                                        arguments: {
                                                          'buThumbDownItemId':
                                                              ProductModel
                                                                      .itemsData()[i]
                                                                  .buItemId,
                                                        })));
                                          },
                                          icon: const Icon(
                                            Icons.thumb_down_alt_rounded,
                                            size: 30.0,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : Row(children: [
                            Container(
                              color: const Color.fromARGB(255, 224, 248, 242),
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Column(children: [
                              for (int j = 0;
                                  j <
                                      ProductModel.itemsData()[i]
                                          .buItemImages
                                          .length;
                                  j++)
                                Listener(
                                  onPointerHover: (event) => {
                                    print('pointerHovered $j'),
                                    setState(() {
                                      isImageHovered = true;
                                      hoveredImageIndex = j;
                                    })
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid)),
                                      width: 50.0,
                                      height: 50.0,
                                      child: Image.network(
                                          ProductModel.itemsData()[i]
                                              .buItemImages[j]),
                                    ),
                                  ),
                                ),
                            ]),
                            Column(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Listener(
                                        onPointerMove: (event) => {
                                              print('pointerMove'),
                                              setState(() {
                                                isColorChanged = true;
                                              })
                                            },
                                        child: PageView(
                                          onPageChanged: (value) => {
                                            print('after swipe'),
                                            setState(() {
                                              isColorChanged = false;
                                            })
                                          },
                                          // controller to set color from each swipe from grey to selectColor
                                          controller: pController,
                                          children: [
                                            for (int j = 0;
                                                j <
                                                    ProductModel.itemsData()[i]
                                                        .buItemImages
                                                        .length;
                                                j++)
                                              ItemImageWebWidget
                                                  .itemDetailsWebImageWidget(
                                                      context,
                                                      !isImageHovered
                                                          ? ProductModel.itemsData()[
                                                                  i]
                                                              .buItemImages[j]
                                                          : ProductModel.itemsData()[
                                                                      i]
                                                                  .buItemImages[
                                                              hoveredImageIndex],
                                                      isColorChanged
                                                          ? Colors.grey
                                                          : selectColor)
                                          ],
                                        ))),

                                //add this section
                                ItemColorComponent().itemsColors(
                                    context,
                                    ProductModel.itemsData()[i].buItemColors,
                                    () => {
                                          setState(() {
                                            selectColor =
                                                ItemColorComponent.thisColor;
                                          })
                                        },
                                    false,
                                    false),
                                Container(
                                  color: Colors.white,
                                  height: kIsWeb ? 30.0 : 10.0,
                                ),
                                Row(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      backgroundColor: const Color.fromARGB(
                                          255, 111, 57, 53),
                                      child: const Icon(Icons.arrow_back),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: IconButton(
                                        color: isThumbsUpClicked &&
                                                !isThumbsDownClicked
                                            ? Colors.red
                                            : null,
                                        onPressed: () {
                                          setState(() {
                                            isThumbsDownClicked = false;
                                            isThumbsUpClicked = true;
                                          });
                                          Timer(const Duration(seconds: 1), () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ThumUpItem(),
                                                    settings: RouteSettings(
                                                        arguments: {
                                                          'buThumbUpItemId':
                                                              ProductModel
                                                                      .itemsData()[i]
                                                                  .buItemId,
                                                        })));
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.thumb_up_alt_rounded),
                                        iconSize: kIsWeb ? 40.0 : 20.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: IconButton(
                                        color: isThumbsDownClicked &&
                                                !isThumbsUpClicked
                                            ? Colors.grey
                                            : null,
                                        onPressed: () {
                                          setState(() {
                                            isThumbsUpClicked = false;
                                            isThumbsDownClicked = true;
                                          });
                                          Timer(const Duration(seconds: 1), () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ThumbDownItem(),
                                                    settings: RouteSettings(
                                                        arguments: {
                                                          'buThumbDownItemId':
                                                              ProductModel
                                                                      .itemsData()[i]
                                                                  .buItemId,
                                                        })));
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.thumb_down_alt_rounded),
                                        iconSize: kIsWeb ? 40.0 : 20.0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              color: const Color.fromARGB(255, 224, 248, 242),
                              width: MediaQuery.of(context).size.width / 5 + 50,
                              height: MediaQuery.of(context).size.height,
                            ),
                          ])
                    : const SizedBox.shrink(),
            ],
          ),
        ));
  }
}
