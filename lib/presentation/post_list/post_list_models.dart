import 'package:domain/model/post.dart';

abstract class PostListState {}

class Success extends PostListState {
  Success({
    this.postList,
  });

  final List<Post> postList;
}

class Loading extends PostListState {}

class Error extends PostListState {}

class NoPostsError extends Error {}
