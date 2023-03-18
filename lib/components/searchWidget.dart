import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchWidget {
  static Widget searchTextField(TextEditingController searchController) {
    return Flexible(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: TextField(
              controller: searchController,
              autofocus: true,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
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
                  fontSize: 20,
                ),
              ),
            )));
  }
}
