import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchWidget {
  static Widget searchTextField(TextEditingController searchController) {
    return Flexible(
        child: SizedBox(
            //constraints: const BoxConstraints(maxWidth: 500),
            width: 200.0,
            child: TextField(
              controller: searchController,
              autofocus: true,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textInputAction: TextInputAction.go,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                ),
              ),
            )));
  }
}
