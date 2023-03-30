import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemImageWidget {
  static Widget ItemDetailsImageWidget(
      BuildContext context, String thisImgSrc, Color thisColor) {
    return SizedBox(
      width: kIsWeb ? MediaQuery.of(context).size.width : 300,
      height: kIsWeb ? MediaQuery.of(context).size.height : 300,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(thisColor, BlendMode.hue),
        child: Container(
          color: Colors.white,
          height: 300,
          //MediaQuery.of(context).size.height,
          width: 300,
          //MediaQuery.of(context).size.width,
          child: Image.network(thisImgSrc),
        ),
      ),
    );
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
