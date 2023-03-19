import 'dart:html';

import 'package:boatusers/components/apiUserProfileFuncs.dart';
import 'package:boatusers/components/searchWidget.dart';
import 'package:boatusers/components/userProfileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final searchController = TextEditingController();
  final formController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String testData = 'Default';

  @override
  void dispose() {
    print('disposed...');
    formController.text = '';
    searchController.dispose();
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Profile'), actions: [
          SearchWidget.searchTextField(searchController),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print(searchController.text);
              })
        ]),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 144.0,
              child: Text('User Profile Page'),
            ),
            userProfileForm(_formKey, context, formController, setState),
            mngDbGetDataDisplay(formController, setState),
            const SizedBox(
              //padding: const EdgeInsets.all(2.0),
              height: 60.0,
              child: Text('DataPage'),
            )
          ],
        ));
  }
}

Widget userProfileForm(
    GlobalKey<FormState> _formKey,
    BuildContext context,
    TextEditingController formController,
    void Function(void Function() thisFunc) thisState) {
  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: formController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 138, 47, 47))),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 47, 20, 146))),
            hintText: 'Enter Text',
            hintStyle: TextStyle(
              color: Color.fromARGB(153, 136, 17, 17),
              fontSize: 20,
            ),
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                thisState(() {});
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    ),
  );
}

Widget mngDbGetDataDisplay(TextEditingController formController,
    void Function(void Function() thisFunc) thisState) {
  if (formController.text != '') {
    thisState(() {});
    return Expanded(
        child: FutureBuilder<List<UserProfileModel>>(
      future: APIUserProfileFuncs.getAllUsers(),
      builder: (context, posts) {
        if (posts.hasData) {
          return ListView(
            //shrinkWrap: true,
            children: APIUserProfileFuncs.buildMngData(posts.data!),
          );
        } else {
          return const Text('No Data');
        }
      },
    ));
  } else
    return const SizedBox.shrink();
}
