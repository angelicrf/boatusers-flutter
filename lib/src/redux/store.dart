import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:boatusers/src/redux/posts/post_action.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';
import 'package:boatusers/src/redux/posts/post_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:path_provider/path_provider.dart';

import '../models/post.dart';
//import 'package:redux_p';

StoreState appReducer(StoreState storestate, dynamic action) {
  print(action);
  if (action is PostState) {
    //print(action.thisPost);
    final nextPostsState = postReducer(storestate.postsState, action);
    return storestate.copyWith(postsState: nextPostsState);
  }

  return storestate;
}

@immutable
class StoreState {
  final PostState postsState;

  const StoreState({
    required this.postsState,
  });

  StoreState copyWith({
    required PostState postsState,
  }) {
    return StoreState(
      postsState: postsState,
    );
  }

  static StoreState fromJson(dynamic json) {
    PostState initUser = PostState(false, false, <Post>[] as List<Post>);
    return StoreState(postsState: initUser);
  }

  dynamic toJson() => {
        'isLoading': postsState.isLoading,
        'isError': postsState.isError,
        'thisPost':
            //(Post data) => json.encode(data).toString()
            jsonEncode(List<Post>.from(postsState.thisPost))
      };
}

class Redux {
  static Store<StoreState> _store = Store<StoreState>(
    appReducer,
    middleware: [thunkMiddleware],
    initialState: StoreState(postsState: PostState.initial()),
  );

  Redux() {
    print(getNewRedux());
  }
  getNewRedux() async {
    return await init();
  }

  static Store<StoreState> get store {
    if (_store != null) return _store;
    if (_store == null) {
      print('emptyStore');
      throw Exception("store is not initialized");
    } else {
      print('NotemptyStore');
      return _store;
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<dynamic> init() async {
    // /data/user/0/com.example.boatusers/app_flutter
    final path = await _localPath;

    final persistor = Persistor<StoreState>(
      storage: FileStorage(File("$path/boatuserstate.json")),
      serializer: JsonSerializer<StoreState>(StoreState.fromJson),
    );
    print('heredata');

    final postsStateInitial = PostState.initial();

    try {
      var persLoad = await persistor.load();
      print('afterload');
      _store = Store<StoreState>(
        appReducer,
        middleware: [persistor.createMiddleware()],
        initialState: persLoad ?? StoreState(postsState: postsStateInitial),
      );
      return _store;
    } catch (e) {
      print(e);
    }
  }
}
