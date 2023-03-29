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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(thisImgSrc),
        ),
      ),
    );
  }
}

class ItemImageWebWidget {
  //loop images
  static Widget itemDetailsWebImageWidget(
      BuildContext context, String thisImgSrc, Color thisColor) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(thisColor, BlendMode.hue),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Image.network(thisImgSrc),
          )),
    );
  }
}
