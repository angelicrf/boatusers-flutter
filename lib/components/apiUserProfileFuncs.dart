import 'dart:convert';
import 'package:boatusers/components/userProfileModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class APIUserProfileFuncs {
  static Future<List<UserProfileModel>> getAllUsers() async {
    //172.17.0.1
    //10.0.2.2
    //change the Url approprately
    var httpUrl = kIsWeb
        ? 'http://172.17.0.1:3000/api/getData'
        : 'http://10.0.2.2:3000/api/getData';
    final response = await http.get(Uri.parse(httpUrl), headers: {
      "Accept": "application/json",
      "Access-Control-Allow_Origin": "*"
    });
    print(jsonDecode(response.body)['msg']);
    if (response.statusCode == 200) {
      List thisResponse = jsonDecode(response.body)['msg'];
      return thisResponse
          .map((value) => UserProfileModel.fromJson(value))
          .toList();
    } else {
      throw Exception('Error from Get data');
    }
  }

  static List<Widget> buildMngData(List<UserProfileModel> posts) {
    return posts
        .map(
          (post) => ListTile(
            title: Text(post.buName),
            subtitle: Text(post.buPassword),
            key: Key(post.id.toString()),
          ),
        )
        .toList();
  }
}
