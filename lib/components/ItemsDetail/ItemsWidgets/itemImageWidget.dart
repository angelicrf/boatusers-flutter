import 'package:flutter/material.dart';

class ItemImageWidget {
  static Widget ItemDetailsImageWidget(
      BuildContext context, String thisImgSrc) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.purple, BlendMode.hue),
        child: Container(
          color: Colors.white,
          height: 500.0,
          width: 400.0,
          child: Image.network(thisImgSrc),
        ),
      ),
    );
  }
}
