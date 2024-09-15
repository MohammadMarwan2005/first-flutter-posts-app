import 'package:dartz/dartz.dart';

import '../../../core/errorhandling/Failure.dart';
import '../repo/posts_repo.dart';

class DeletePostUseCase {
  final PostsRepo postRepo;

  DeletePostUseCase(this.postRepo);

  Future<Either<Failure, Unit>> call(id) async{
    return await postRepo.deletePost(id);
  }

}
