part of 'adu_post_bloc.dart';

@immutable
sealed class ADUPostEvent extends Equatable{}

class AddPostEvent extends ADUPostEvent {
  final Post post;

  AddPostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends ADUPostEvent {
  final int postId;

  DeletePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class UpdatePostEvent extends ADUPostEvent {
  final Post post;

  UpdatePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}
class ResetEvent extends ADUPostEvent {
  @override
  List<Object?> get props => [];
}
