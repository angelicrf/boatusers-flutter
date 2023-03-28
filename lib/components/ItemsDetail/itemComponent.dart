import 'package:boatusers/Models/productModel.dart';
import 'package:boatusers/components/ItemsDetail/ItemsWidgets/itemImageWidget.dart';
import 'package:boatusers/components/boatItems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemComponent extends StatefulWidget {
  const ItemComponent({super.key});

  @override
  State<ItemComponent> createState() => _ItemComponentState();
}

class _ItemComponentState extends State<ItemComponent> {
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
              ...ProductModel.itemsData().map((e) => e.buItemId == buId
                  ? Expanded(
                      child: ItemImageWidget.ItemDetailsImageWidget(
                          context, e.buItemImages[0]))
                  : const SizedBox.shrink()),
              Container(
                color: Colors.white,
                height: kIsWeb ? 30.0 : 10.0,
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 177, 42, 60),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BoatItems()),
                        );
                      },
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
