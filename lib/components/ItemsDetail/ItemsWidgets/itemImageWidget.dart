import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemImageWidget {
  static Widget ItemDetailsImageWidget(
      BuildContext context, String thisImgSrc, Color thisColor) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: SizedBox(
          width: kIsWeb ? MediaQuery.of(context).size.width : 320,
          height: kIsWeb ? MediaQuery.of(context).size.height : 300,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(thisColor, BlendMode.hue),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              height: 300,
              //MediaQuery.of(context).size.height,
              width: 320,
              //MediaQuery.of(context).size.width,
              child: Image.network(thisImgSrc),
            ),
          ),
        ));
  }
}

class ItemImageWebWidget {
  static Widget itemDetailsWebImageWidget(
      BuildContext context, String thisImgSrc, Color thisColor) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(thisColor, BlendMode.hue),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(thisImgSrc),
        ));
  }
}
