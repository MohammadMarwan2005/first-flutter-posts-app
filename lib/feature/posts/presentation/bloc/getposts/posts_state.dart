part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
}

final class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}
final class IsLoading extends PostsState {
  @override
  List<Object> get props => [];
}
final class GetPostsFailureState extends PostsState {
  final String message;
  const GetPostsFailureState(this.message);

  @override
  List<Object> get props => [message];
}

final class LoadedPosts extends PostsState {
  final List<Post> posts;

  const LoadedPosts(this.posts);

  @override
  List<Object> get props => [posts];
}
