import 'package:boatusers/src/redux/posts/post_action.dart';
import 'package:boatusers/src/redux/posts/post_state.dart';

import '../../models/post.dart';

postReducer(PostState prevState, PostState setaction) {
  final payload = setaction;
  print(payload.isLoading);

  return prevState.copyWith(
    isLoading: payload.isLoading,
    isError: payload.isError,
    thisPost: payload.thisPost,
  );
}
