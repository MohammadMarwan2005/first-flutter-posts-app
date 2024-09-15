import 'package:dartz/dartz.dart';

import '../../../core/errorhandling/Failure.dart';
import '../domainmodel/post.dart';

// Learned: You don't have to make a repo for every use case, for ex:

abstract class PostsRepo {
  // Learned: in android, you should make this function "suspend" function...
  // as that, in flutter, you make this function returns future...
  Future<Either<Failure, List<Post>>> getAllPosts();

  // Learned: you still can make this function returns Future<bool>, so if this process succeeded you return true, else false
  // but it's a traditional way!
  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}


