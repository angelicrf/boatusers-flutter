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
  String myName = '';
  @override
  void dispose() {
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
            //userProfileForm(_formKey, context, formController, myName),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: formController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 138, 47, 47))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 47, 20, 146))),
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
                          // api call
                          var getData = await APIUserProfileFuncs.getAllUsers();
                          print(getData);
                          setState(() {
                            this.myName = formController.text;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            Text(myName),
            (() {
              if (myName != '') {
                print('name is not null');
                return mngDbGetDataDisplay();
              } else
                return SizedBox.shrink();
            }())
          ],
        ));
  }
}

Widget mngDbGetDataDisplay() {
  return Expanded(
      child: FutureBuilder<List<UserProfileModel>>(
    future: APIUserProfileFuncs.getAllUsers(),
    builder: (context, posts) {
      if (posts.hasData) {
        return ListView(
            children: APIUserProfileFuncs.buildMngData(posts.data!));
      } else {
        return Text('No Data');
      }
    },
  ));
}

Widget userProfileForm(GlobalKey<FormState> _formKey, BuildContext context,
    TextEditingController formController, String thisName) {
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
                // api call
                var getData = await APIUserProfileFuncs.getAllUsers();
                print(getData);
                thisName = formController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    ),
  );
}
