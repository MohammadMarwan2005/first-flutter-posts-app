import 'package:dartz/dartz.dart';

import '../../../core/errorhandling/Failure.dart';
import '../domainmodel/post.dart';
import '../repo/posts_repo.dart';

class AddPostUseCase {
  final PostsRepo postRepo;

  AddPostUseCase(this.postRepo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepo.addPost(post);
  }
}
