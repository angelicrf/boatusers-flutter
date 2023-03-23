import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemColorComponent {
  Widget itemsColors(BuildContext context, List<Color> itemColors) {
    var listItems = <Widget>[
      const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text('Colors:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ))),
      const SizedBox(
        width: 10.0,
      )
    ];

    itemColors.forEach((element) {
      listItems.add(Row(
        children: [
          Container(
            width: 50.0,
            //MediaQuery.of(context).size.width / 7,
            height: 50.0,
            decoration: BoxDecoration(
                color: element,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3.0)),
            child: const Icon(
              Icons.abc,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10.0,
          )
        ],
      ));
    });
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listItems,
        ));
  }
}
