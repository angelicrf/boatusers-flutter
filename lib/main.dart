import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:boatusers/src/redux/store.dart';
import 'package:boatusers/src/models/post.dart';
import 'package:boatusers/src/redux/posts/post_action.dart';

void main() async {
  runApp(const BoatUsersApp());
  if (!kIsWeb) {
    Redux();
  }
}

class BoatUsersApp extends StatelessWidget {
  const BoatUsersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Boat Users',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: StoreProvider<StoreState>(
          store: Redux.store,
          child: BUHomePage(buTitle: 'Boat Users App'),
        ));
  }
}

class BUHomePage extends StatefulWidget {
  const BUHomePage({super.key, required this.buTitle});

  final String buTitle;

  @override
  State<BUHomePage> createState() => _BUHomePageState();
}

class _BUHomePageState extends State<BUHomePage> {
  int _buCount = 0;
  final buserNameController = TextEditingController();
  final buPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initStateCalled....');
  }

  @override
  void dispose() {
    buPasswordController.dispose();
    buserNameController.dispose();
    super.dispose();
  }

  _onFetchPostsPressed() async {
    await Redux.store.dispatch(fetchPostsAction);
    print('onFetchCalled');
    setState(() {
      this._buCount += 20;
    });
  }

  void _SubmitInputs() async {
    /*   setState(() {
      _buCount += 20;
    }); */
    if (buPasswordController.text != '' && buserNameController.text != '') {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Confirmed UserName: ${buserNameController.text} and Password: ${buPasswordController.text}'),
          );
        },
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buTitle),
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
              if (posts.isNotEmpty) {
                return ListView(children: _buildPosts(posts));
              } else {
                return Text('No Data');
              }
            },
          ))
        ],
      )),
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
