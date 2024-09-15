import 'package:dartz/dartz.dart';

import '../../../core/errorhandling/Failure.dart';
import '../domainmodel/post.dart';
import '../repo/posts_repo.dart';

class UpdatePostUseCase {
  final PostsRepo postRepo;

  UpdatePostUseCase(this.postRepo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepo.updatePost(post);
  }

}
