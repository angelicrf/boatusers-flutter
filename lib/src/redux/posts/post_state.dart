import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:boatusers/src/models/post.dart';

//@immutable
class PostState {
  bool isLoading = false;
  bool isError = false;
  List<Post> thisPost = <Post>[] as List<Post>;

  PostState(isLoading, isError, thisPost) {
    this.isLoading = isLoading;
    this.isError = isError;
    this.thisPost = thisPost;
  }

  factory PostState.initial() => PostState(
        false,
        false,
        <Post>[] as List<Post>,
      );

  PostState copyWith({
    required bool isLoading,
    required bool isError,
    required List<Post> thisPost,
  }) {
    return PostState(
      isLoading,
      isError,
      thisPost,
    );
  }
}
