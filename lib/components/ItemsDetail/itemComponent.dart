import 'package:boatusers/components/boatItems.dart';
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
    final String buId = arguments['buItemId'].toString();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Text(buId),
              FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 177, 42, 60),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BoatItems()),
                  );
                },
                child: const Icon(Icons.arrow_back),
              )
            ],
          ),
        ));
  }
}
