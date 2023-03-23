import 'package:boatusers/components/apiUserProfileFuncs.dart';
import 'package:boatusers/components/searchWidget.dart';
import 'package:boatusers/Models/userProfileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final searchController = TextEditingController();
  final formController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isGetMngDb = false;
  bool isPostMngDb = false;

  @override
  void dispose() {
    print('disposed...');
    formController.text = '';
    passwordController.text = '';
    searchController.dispose();
    formController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool thisFunbool() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const SizedBox(
            width: kIsWeb ? 220.0 : 50.0,
            child: Text(
              kIsWeb ? 'User Profile' : 'Profile',
              style: TextStyle(
                fontSize: kIsWeb ? 18.0 : 12.0,
              ),
            ),
          ),
          actions: [
            SearchWidget.searchTextField(searchController),
            SizedBox(
                child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      print(searchController.text);
                    }))
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 80.0,
              child: const Text('User Profile Page'),
            ),
            userProfileForm(
                _formKey,
                context,
                formController,
                passwordController,
                () => setState(() {
                      isPostMngDb = true;
                    }),
                () => setState(() {
                      isGetMngDb = true;
                    })),
            mngDbGetDataDisplay(
                isGetMngDb, () => setState(() => isPostMngDb = false), context),
            mngDbPostDataDisplay(
                isPostMngDb,
                formController,
                passwordController,
                () => setState(() => isGetMngDb = false),
                context),
            SizedBox(
              //padding: const EdgeInsets.all(2.0),
              height: 60.0,
              child: Text(isGetMngDb.toString()),
            )
          ],
        ));
  }
}

Widget userProfileForm(
    GlobalKey<FormState> _formKey,
    BuildContext context,
    TextEditingController formController,
    TextEditingController passwordController,
    void Function() thisState,
    void Function() thisBoolState) {
  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: TextFormField(
              controller: formController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 138, 47, 47))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 47, 20, 146))),
                hintText: 'Enter User Name',
                labelText: 'User Name',
                contentPadding: EdgeInsets.all(18),
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
            )),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 138, 47, 47))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(47, 20, 146, 1))),
                hintText: 'Enter Password',
                labelText: 'Password',
                contentPadding: EdgeInsets.all(18),
                hintStyle: TextStyle(
                  color: Color.fromARGB(153, 136, 17, 17),
                  fontSize: 20,
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            )),
        Row(
          children: <Widget>[
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    thisState();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(width: 16),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.data_array),
                    onPressed: () {
                      thisBoolState();
                    }))
          ],
        ),
      ],
    ),
  );
}

Widget mngDbGetDataDisplay(
    bool isMngdbGet, void Function() thisState, BuildContext context) {
  if (isMngdbGet) {
    thisState();
    return Expanded(
        child: FutureBuilder<List<UserProfileModel>>(
      future: APIUserProfileFuncs.getAllUsers(),
      builder: (context, posts) {
        if (posts.hasData) {
          return ListView(
            //shrinkWrap: true,
            children: APIUserProfileFuncs.buildMngData(posts.data!, context),
          );
        } else {
          return const Text('No Data');
        }
      },
    ));
  } else
    return const SizedBox.shrink();
}

Widget mngDbPostDataDisplay(
    bool isMngdbPost,
    TextEditingController formController,
    TextEditingController passwordController,
    void Function() thisState,
    BuildContext context) {
  if (isMngdbPost) {
    print('postData');
    thisState();
    return Expanded(
        child: FutureBuilder<List<UserProfileModel>>(
      future: APIUserProfileFuncs.postUser(
          formController.text, passwordController.text),
      builder: (context, posts) {
        print(posts);
        if (posts.hasData) {
          return ListView(
            children: APIUserProfileFuncs.buildMngData(posts.data!, context),
          );
        } else {
          return const Text('No Data To Insert');
        }
      },
    ));
  } else {
    return const SizedBox.shrink();
  }
}
