import 'dart:async';
import 'dart:convert';

import 'package:boatusers/components/about.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:boatusers/src/redux/store.dart';
import 'package:boatusers/src/models/post.dart';
import 'package:boatusers/src/redux/posts/post_action.dart';
import 'package:http/http.dart' as http;
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

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
    return MaterialApp(
        title: 'Boat Users',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: StoreProvider<StoreState>(
          store: Redux.store,
          child: BUHomePage('Boat Users App', UniqueKey()),
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

  final buserNameController = TextEditingController();
  final buPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initStateCalled....');
  }

  @override
  void didChangeDependencies() {
    print('stateupdated $_buCount');
  }

  @override
  void dispose() {
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
          return AlertDialog(
            content: Text('Empty Password Field!'),
          );
        },
      );
    } else if (buserNameController.text == '' &&
        buPasswordController.text != '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Empty User Name Field!'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Invalid Entry!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      var thisValue = Redux.store.state.postsState.thisPost;
      print(thisValue);
      StoreProvider.of<StoreState>(context).state.postsState.thisPost =
          thisValue;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.buTitle),
          key: (widget.key),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'User Info',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'User Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: buserNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter User Name',
                ),
              ),
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '$_buCount',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: buPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: FloatingActionButton(
                onPressed: _SubmitInputs,
                tooltip: 'Enter',
                child: const Icon(Icons.send),
                //style:FloatingActionButtonLocation.startFloat
              ),
              //,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: FloatingActionButton(
                onPressed: _onFetchPostsPressed,
                heroTag: null,
                tooltip: 'Get Data',
                child: const Icon(Icons.get_app),
              ),
              //,
            ),
/*           FutureBuilder(
              future: Future.delayed(Duration(seconds: 10)),
              builder: (c, s) => s.connectionState == ConnectionState.done ? */
            StoreConnector<StoreState, bool>(
              distinct: true,
              converter: (store) => store.state.postsState.isLoading,
              builder: (context, isLoading) {
                if (isLoading) {
                  return CircularProgressIndicator();
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            // : Text("Loading...")),
            StoreConnector<StoreState, bool>(
              distinct: true,
              converter: (store) => store.state.postsState.isError,
              builder: (context, isError) {
                if (isError) {
                  return Text("Failed to get posts");
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            Expanded(
                child: StoreConnector<StoreState, List<Post>>(
              distinct: true,
              converter: (store) => store.state.postsState.thisPost,
              builder: (context, posts) {
                print(posts);
                if (posts.isNotEmpty) {
                  return ListView(children: _buildPosts(posts));
                } else {
                  return Text('No Data');
                }
              },
            ))
          ],
        ))
        //
        );
  }

  List<Widget> _buildPosts(List<Post> posts) {
    return posts
        .map(
          (post) => ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            key: Key(post.id.toString()),
          ),
        )
        .toList();
  }
}
