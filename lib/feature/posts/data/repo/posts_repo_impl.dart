import 'package:clean_architecture_posts_app/feature/core/errorhandling/Exception.dart';
import 'package:clean_architecture_posts_app/feature/core/errorhandling/Failure.dart';
import 'package:clean_architecture_posts_app/feature/posts/data/datamodel/post_model.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/domainmodel/post.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/repo/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../datasource/api_service.dart';
import '../networkchcker/network_info.dart';

class PostsRepoImpl implements PostsRepo {
  final APIService apiService;
  final NetworkInfo networkInfo;

  PostsRepoImpl(this.apiService, this.networkInfo);

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await apiService.getAllPosts());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel = PostModel(userId: post.userId, id: post.id, title: post.title, body: post.title);
    if(await networkInfo.isConnected) {
      try {
        return Right(await apiService.addPost(postModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel = PostModel(userId: post.userId, id: post.id, title: post.title, body: post.title);
    if(await networkInfo.isConnected) {
      try {
        return Right(await apiService.updatePost(postModel));
    } on ServerException {
    return Left(ServerFailure());
    }
    } else {
    return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if(await networkInfo.isConnected) {
      try {
        return Right(await apiService.deletePost(id));
    } on ServerException {
    return Left(ServerFailure());
    }
    } else {
    return Left(NoInternetFailure());
    }
  }

}
