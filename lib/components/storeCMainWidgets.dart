import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../src/models/post.dart';
import '../src/redux/store.dart';

class StoreCMainWidgets {
  const StoreCMainWidgets(BuildContext context);

  List<Widget> storeConnectorW() => [
        StoreConnector<StoreState, bool>(
          distinct: true,
          converter: (store) => store.state.postsState.isLoading,
          builder: (context, isLoading) {
            if (isLoading) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        StoreConnector<StoreState, bool>(
          distinct: true,
          converter: (store) => store.state.postsState.isError,
          builder: (context, isError) {
            if (isError) {
              return const Text("Failed to get posts");
            } else {
              return const SizedBox.shrink();
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
              return const Text('No Data');
            }
          },
        ))
      ];
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
