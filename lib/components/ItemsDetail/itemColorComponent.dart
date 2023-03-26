import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemColorComponent {
  static Color thisColor = Colors.black;
  Widget itemsColors(BuildContext context, List<Color> itemColors,
      void Function() colorPressed) {
    var listItems = <Widget>[
      const SizedBox(
        width: 10.0,
      )
    ];

    for (var element in itemColors) {
      listItems.add(Row(
        children: [
          Container(
            width: kIsWeb ? 50.0 : 35.0,
            //MediaQuery.of(context).size.width / 7,
            height: kIsWeb ? 50.0 : 35.0,
            decoration: BoxDecoration(
                color: element,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3.0)),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.abc,
                //fill: 1.0,
              ),
              color: Colors.black,
              onPressed: () => {
                print(thisColor.value.toString()),
                thisColor = element,
                colorPressed(),
                print(thisColor.value)
              },
            ),
          ),
          const SizedBox(
            width: 10.0,
          )
        ],
      ));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...listItems,
          ],
        ));
  }
}
