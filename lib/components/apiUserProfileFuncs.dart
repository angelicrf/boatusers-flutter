import 'dart:convert';
import 'package:boatusers/components/profileUserUpdateForm.dart';
import 'package:boatusers/Models/userProfileModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class APIUserProfileFuncs {
  static Future<List<UserProfileModel>> getAllUsers() async {
    //172.17.0.1
    //10.0.2.2
    //192.168.1.24
    //change the Url approprately
    var httpUrl = kIsWeb
        ?
        //'http://172.17.0.1:3000/api/getData'
        'http://192.168.1.24:3000/api/getData'
        : Platform.isIOS
            ? 'http://localhost:3000/api/getData'
            : Platform.isAndroid
                ? 'http://10.0.2.2:3000/api/getData'
                : '';

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

  static Future<List<UserProfileModel>> getUser(thisId) async {
    //172.17.0.1 Linux
    //10.0.2.2
    //change the Url approprately
    var httpUrl = kIsWeb
        ? 'http://192.168.1.24:3000/api/getIdData?thisId=$thisId'
        : Platform.isAndroid
            ? 'http://10.0.2.2:3000/api/getIdData?thisId=$thisId'
            : Platform.isIOS
                ? 'http://localhost:3000/api/getIdData?thisId=$thisId'
                : '';

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
      throw Exception('Error from GetId data');
    }
  }

  static Future<List<UserProfileModel>> updateUser(
      thisId, thisUserName, thisUserpassword) async {
    print('UpdateUserCalled $thisId');
    List thisUpadteList = List.empty(growable: true);
    Map<String, String> body = {
      'buId': '$thisId',
      'buName': '$thisUserName',
      'buPassword': '$thisUserpassword',
    };

    var httpUrl = kIsWeb
        ? 'http://192.168.1.24:3000/api/updateData'
        : Platform.isAndroid
            ? 'http://10.0.2.2:3000/api/updateData'
            : Platform.isIOS
                ? 'http://localhost:3000/api/updateData'
                : '';
    final response = await http.put(Uri.parse(httpUrl),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow_Origin": "*"
        },
        body: body);
    print(jsonDecode(response.body)['msg']);
    if (response.statusCode == 200) {
      thisUpadteList.add(jsonDecode(response.body)['msg']);
      return thisUpadteList
          .map((value) => UserProfileModel.fromJson(value))
          .toList();
    } else {
      throw Exception('Error from Update data');
    }
  }

  static Future<String> deleteUser(thisName) async {
    var httpUrl = kIsWeb
        ? 'http://192.168.1.24:3000/api/deleteData?buName=$thisName'
        : Platform.isAndroid
            ? 'http://10.0.2.2:3000/api/deleteData?buName=$thisName'
            : Platform.isIOS
                ? 'http://localhost:3000/api/deleteData?buName=$thisName'
                : '';
    final response = await http.delete(Uri.parse(httpUrl), headers: {
      "Accept": "application/json",
      "Access-Control-Allow_Origin": "*"
    });
    print(jsonDecode(response.body)['msg']);
    if (response.statusCode == 200) {
      var thisResponse = jsonDecode(response.body)['msg'];
      return thisResponse.toString();
    } else {
      throw Exception('Error from Delete data');
    }
  }

  static onCardClick(thisId) {
    print('clicked Main Card $thisId');
  }

  static onDeleteClick(thisName) {
    print('clicked Delete Card $thisName');
    deleteUser(thisName);
  }

  static onUpdateClick(thisId, thisName, thisPassword, BuildContext context) {
    print('clicked Update Card $thisId');
    //updateUser(thisId, 'testUpdate56', '985471');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ProfileUserUpdateForm(),
        settings: RouteSettings(arguments: {
          'buId': thisId,
          'buName': '$thisName',
          'buPassword': '$thisPassword'
        })));
  }

  static List<Widget> buildMngData(
      List<UserProfileModel> posts, BuildContext context) {
    return posts
        .map((post) =>
            //GestureDetector(
            // onTap: () => onCardClick(post.id), //onCardClick(post.id),
            //child:
            Card(
                color: const Color.fromARGB(255, 153, 182, 197),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text(post.buName),
                    subtitle: Text(post.buPassword),
                    key: Key(post.id.toString()),
                  )),
                  IconButton(
                    onPressed: () => onDeleteClick(post.buName.toString()),
                    icon: const Icon(Icons.delete),
                    color: Colors.redAccent,
                  ),
                  IconButton(
                    onPressed: () => onUpdateClick(
                        post.id.toString(),
                        post.buName.toString(),
                        post.buPassword.toString(),
                        context),
                    icon: const Icon(Icons.update),
                    color: Colors.blueAccent,
                  ),
                ])))
        .toList();
  }

  static Future<List<UserProfileModel>> postUser(
      thisUserName, thisPassword) async {
    List thisList = List.empty(growable: true);
    Map<String, dynamic> body = {
      'buName': '$thisUserName',
      'buPassword': '$thisPassword',
    };
    var httpUrl = kIsWeb
        ? 'http://192.168.1.24:3000/api/postData'
        : 'http://10.0.2.2:3000/api/postData';
    final response = await http.post(Uri.parse(httpUrl),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow_Origin": "*"
        },
        body: body);
    print(jsonDecode(response.body)['msg']);

    if (response.statusCode == 200) {
      thisList.add(jsonDecode(response.body)['msg']);
      if (thisList.isNotEmpty) {
        print('thislist is not empty');
        return thisList
            .map((value) => UserProfileModel.fromJson(value))
            .toList();
      } else {
        return thisList
            .map((value) => UserProfileModel.fromJson(value))
            .toList();
      }
    } else {
      throw Exception('Error from Post data');
    }
  }
}
