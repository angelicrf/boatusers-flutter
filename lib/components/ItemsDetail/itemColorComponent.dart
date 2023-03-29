import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemColorComponent {
  static Color thisColor = Colors.black;
  Widget itemsColors(BuildContext context, List<Color> itemColors,
      void Function() colorPressed, bool isHorizantal, bool isVertical) {
    var listItems = <Widget>[
      const SizedBox(
        width: 10.0,
      )
    ];

    for (var element in itemColors) {
      listItems.add(Row(
        children: [
          Container(
            width: kIsWeb && (isHorizantal || isVertical)
                ? 35.0
                : isHorizantal || isVertical
                    ? 35.0
                    : kIsWeb && (!isHorizantal || !isVertical)
                        ? 60.0
                        : 60.0,
            height: kIsWeb && (isHorizantal || isVertical)
                ? 35.0
                : isHorizantal || isVertical
                    ? 35.0
                    : kIsWeb && (!isHorizantal || !isVertical)
                        ? 60.0
                        : 60.0,
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
        child: Container(
          color: !isHorizantal ? Colors.white : Colors.transparent,
          width: !isHorizantal ? MediaQuery.of(context).size.width : 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...listItems,
            ],
          ),
        ));
  }
}
