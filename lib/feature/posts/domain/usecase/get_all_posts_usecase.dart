import 'package:clean_architecture_posts_app/feature/core/errorhandling/Failure.dart';
import 'package:dartz/dartz.dart';

import '../domainmodel/post.dart';
import '../repo/posts_repo.dart';

class GetAllPostsUseCase {
  final PostsRepo postRepo;


  GetAllPostsUseCase(this.postRepo);

  Future<Either<Failure, List<Post>>> call() async {
    return await postRepo.getAllPosts();
  }

}