import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:boatusers/src/redux/posts/post_action.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';
import 'package:boatusers/src/redux/posts/post_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';

StoreState appReducer(StoreState storestate, dynamic action) {
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
}

class Redux {
  static Store<StoreState> _store = Store<StoreState>(appReducer,
      middleware: [thunkMiddleware],
      initialState: StoreState(postsState: PostState.initial()));

  static Store<StoreState> get store {
    if (_store == null) {
      print('emptyStore');
      throw Exception("store is not initialized");
    } else {
      print('NotemptyStore');
      return _store;
    }
  }

  static Future<void> init() async {
    print('initCalled');
    final postsStateInitial = PostState.initial();

    _store = Store<StoreState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: StoreState(postsState: postsStateInitial),
    );
  }
}
