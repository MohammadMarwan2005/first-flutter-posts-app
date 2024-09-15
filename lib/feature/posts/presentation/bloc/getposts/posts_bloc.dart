import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/feature/core/errorhandling/Failure.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/repo/posts_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/domainmodel/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo postsRepo;

  PostsBloc({required this.postsRepo}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(IsLoading());
        final posts = await postsRepo.getAllPosts();
        posts.fold((failure) {
          emit(GetPostsFailureState(mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPosts(posts));
        });
      } else if (event is RefreshEvent) {
        emit(IsLoading());
        final posts = await postsRepo.getAllPosts();
        posts.fold((failure) {
          emit(GetPostsFailureState(mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPosts(posts));
        }
        );
      }
    });
  }
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return "Server Failure";
    case const (NoInternetFailure):
      return "No Internet Connection";
    default:
      return "Something Went Wrong";
  }
}
