part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();
}
class GetAllPostsEvent extends PostsEvent {
  const GetAllPostsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RefreshEvent extends PostsEvent {
  const RefreshEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
