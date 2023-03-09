import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:boatusers/src/models/post.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';
import 'package:boatusers/src/redux/posts/post_reducer.dart';
import 'package:http/http.dart' as http;

import '../store.dart';

Future<void> fetchPostsAction(Store<StoreState> store) async {
  await store.dispatch(PostState(true, false, <Post>[] as List<Post>));

  try {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);
    var thisValue = Post.listofObjects(jsonData);

    await store.dispatch(
      PostState(false, false, thisValue),
    );
  } catch (error) {
    store.dispatch(PostState(false, true, <Post>[] as List<Post>));
  }
}
