import 'dart:convert';

import 'package:boatusers/components/apiUserProfileFuncs.dart';
import 'package:boatusers/components/userProfile.dart';
import 'package:boatusers/components/userProfileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileUserUpdateForm extends StatefulWidget {
  const ProfileUserUpdateForm({Key? key}) : super(key: key);

  @override
  _ProfileUserUpdateFormState createState() => _ProfileUserUpdateFormState();
}

class _ProfileUserUpdateFormState extends State<ProfileUserUpdateForm> {
  final formController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formController.text = '';
    passwordController.text = '';
    formController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)?.settings.arguments) as Map<dynamic, dynamic>;
    formController.text = arguments['buName'];
    passwordController.text = arguments['buPassword'];

    print(arguments);
    return Scaffold(
      body: userProfileForm(
        arguments['buId'].toString(),
        arguments['buName'].toString(),
        arguments['buPassword'].toString(),
        _formKey,
        context,
        formController,
        passwordController,
      ),
    );
  }

  Widget userProfileForm(
    String thisUserId,
    String thisUserName,
    String thisUserPassword,
    GlobalKey<FormState> _formKey,
    BuildContext context,
    TextEditingController formController,
    TextEditingController passwordController,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'User Name',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
          TextFormField(
              controller: formController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 138, 47, 47))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 47, 20, 146))),
                hintText: 'Enter User Name',
                contentPadding: EdgeInsets.all(8.0),
                hintStyle: TextStyle(
                  color: Color.fromARGB(153, 136, 17, 17),
                  fontSize: 20,
                ),
              )),
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Password',
                style: TextStyle(fontSize: 20),
              )),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 138, 47, 47))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(47, 20, 146, 1))),
              hintText: 'Enter Password',
              contentPadding: EdgeInsets.all(8.0),
              hintStyle: TextStyle(
                color: Color.fromARGB(153, 136, 17, 17),
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                await APIUserProfileFuncs.updateUser(
                    thisUserId, formController.text, passwordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
