import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:boatusers/components/about.dart';
import 'package:boatusers/components/footerMb.dart';
import 'package:boatusers/components/footerWeb.dart';
import 'package:boatusers/components/mainWidgets.dart';
import 'package:boatusers/routes/routesHandler.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:boatusers/src/redux/store.dart';
import 'package:boatusers/src/models/post.dart';
import 'package:boatusers/src/redux/posts/post_action.dart';
import 'package:http/http.dart' as http;
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'components/searchWidget.dart';
import 'components/storeCMainWidgets.dart';
import 'src/redux/store.dart';

void main() async {
  runApp(const BoatUsersApp());
  Redux();
}

class BoatUsersApp extends StatelessWidget {
  const BoatUsersApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('firstClassCalled');
    return StoreProvider<StoreState>(
        store: Redux.store,
        child: kIsWeb || Platform.isAndroid
            ? MaterialApp(
                title: 'Boat Users',
                theme: ThemeData(
                    primarySwatch: Colors.cyan,
                    scaffoldBackgroundColor:
                        Color.fromARGB(255, 224, 248, 242)),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: handleRoutes,
                home: BUHomePage('Boat Users App', UniqueKey()),
              )
            : CupertinoApp(
                title: 'Boat Users',
                theme: const CupertinoThemeData(
                  primaryColor: Colors.cyan,
                  scaffoldBackgroundColor: Color.fromARGB(255, 224, 248, 242),
                ),
                onGenerateRoute: handleRoutes,
                home: BUHomePage('Boat Users App', UniqueKey()),
              ));
  }
}

class BUHomePage extends StatefulWidget {
  const BUHomePage(this.buTitle, this.key) : super(key: key);
  final Key key;
  final String buTitle;

  @override
  State<BUHomePage> createState() => _BUHomePageState();
}

class _BUHomePageState extends State<BUHomePage> {
  int _buCount = 0;
  bool isRendered = false;
  int _indexSelected = 0;
  late List<Widget> mWidgets;
  late List<Widget> stCWidgets;
  final buserNameController = TextEditingController();
  final buPasswordController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initStateCalled....');
  }

  @override
  void dispose() {
    searchController.dispose();
    buPasswordController.dispose();
    buserNameController.dispose();
    super.dispose();
  }

  _onFetchPostsPressed() async {
    await Redux.store.dispatch(PostState(true, false, <Post>[] as List<Post>));
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      assert(response.statusCode == 200);
      final jsonData = json.decode(response.body);
      var thisValue = Post.listofObjects(jsonData);

      await Redux.store.dispatch(
        PostState(false, false, thisValue),
      );
      setState(() {
        this._buCount += 20;
      });
    } catch (error) {
      Redux.store.dispatch(PostState(false, true, <Post>[] as List<Post>));
    }
  }

  void _SubmitInputs() async {
    if (buPasswordController.text != '' && buserNameController.text != '') {
      String appUName = buserNameController.text;
      String appPwd = buPasswordController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => About(
            appUserName: '$appUName',
            appUserPassword: '$appPwd',
          ),
        ),
      );
      setState(() {
        buPasswordController.text = '';
        buserNameController.text = '';
      });
    } else if (buPasswordController.text == '' &&
        buserNameController.text != '') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Empty Password Field!'),
          );
        },
      );
    } else if (buserNameController.text == '' &&
        buPasswordController.text != '') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Empty User Name Field!'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Invalid Entry!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    stCWidgets = StoreCMainWidgets(context).storeConnectorW();
    mWidgets = MainWidgets().thisW(context, buserNameController,
        buPasswordController, _buCount, _SubmitInputs, _onFetchPostsPressed);

    if (!kIsWeb) {
      var thisValue = Redux.store.state.postsState.thisPost;

      print(thisValue);
      StoreProvider.of<StoreState>(context).state.postsState.thisPost =
          thisValue;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(
          width: kIsWeb ? 220.0 : 50.0,
          child: Text(
            kIsWeb ? widget.buTitle : 'Home',
            style: const TextStyle(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ...mWidgets,
            ...stCWidgets,
            (() {
              if (!kIsWeb) {
                return Container(
                  color: Colors.amber,
                  child: FooterMB(),
                );
              } else
                return SizedBox.shrink();
            }())
          ],
        ),
      ),
      bottomNavigationBar: kIsWeb ? FooterWeb() : const SizedBox.shrink(),
    );
  }
}
