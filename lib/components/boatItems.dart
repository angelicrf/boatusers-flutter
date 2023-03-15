import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoatItems extends StatefulWidget {
  const BoatItems({Key? key}) : super(key: key);

  @override
  _BoatItemsState createState() => _BoatItemsState();
}

class _BoatItemsState extends State<BoatItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Boat Items'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          height: 144.0,
          child: Text('Boat Items Page'),
        ));
  }
}
