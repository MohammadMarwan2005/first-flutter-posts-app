import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/domainmodel/post.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/repo/posts_repo.dart';
import 'package:clean_architecture_posts_app/feature/posts/presentation/bloc/getposts/posts_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'adu_post_event.dart';
part 'adu_post_state.dart';

class ADUPostBloc extends Bloc<ADUPostEvent, ADUPostState> {
  final PostsRepo postsRepo;

  ADUPostBloc(this.postsRepo) : super(ADUInitial()) {
    on<ADUPostEvent>((event, emit) async {
      switch (event.runtimeType) {
        case const (AddPostEvent):
          {
            emit(IsLoadingState());
            final addResponse =
                await postsRepo.addPost((event as AddPostEvent).post);
            addResponse.fold((failure) {
              emit(FailureState(mapFailureToMessage(failure)));
            }, (success) {
              emit(SuccessState("Added Successfully!"));
            });
          }
        case const (DeletePostEvent):
          {
            emit(IsLoadingState());
            final deleteResponse =
                await postsRepo.deletePost((event as DeletePostEvent).postId);
            deleteResponse.fold((failure) {
              emit(FailureState(mapFailureToMessage(failure)));
            }, (success) {
              emit(SuccessState("Deleted Successfully!"));
            });
          }
        case const (UpdatePostEvent):
          {
            emit(IsLoadingState());
            final deleteResponse =
                await postsRepo.updatePost((event as UpdatePostEvent).post);
            deleteResponse.fold((failure) {
              emit(FailureState(mapFailureToMessage(failure)));
            }, (success) {
              emit(SuccessState("Updated Successfully!"));
            });
          }
        case const (ResetEvent):
          {
            emit(ADUInitial());
          }
      }
    });
  }
}
