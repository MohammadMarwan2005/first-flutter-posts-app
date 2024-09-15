import 'package:clean_architecture_posts_app/feature/posts/data/datasource/api_service.dart';
import 'package:clean_architecture_posts_app/feature/posts/data/networkchcker/network_info.dart';
import 'package:clean_architecture_posts_app/feature/posts/data/repo/posts_repo_impl.dart';
import 'package:clean_architecture_posts_app/feature/posts/domain/repo/posts_repo.dart';
import 'package:clean_architecture_posts_app/feature/posts/presentation/bloc/getposts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/feature/posts/presentation/bloc/post_details/adu_post_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  // Provide NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(InternetConnectionChecker()));

  // Hey you, MR OverEngineer, don't provide UseCases :)
  // Provide APIService
  getIt.registerLazySingleton<APIService>(() => APIServiceImpl(http.Client()));

  // Learned: make it lazy...
  // Provide Repo
  getIt.registerLazySingleton<PostsRepo>(() => PostsRepoImpl(getIt(), getIt()));

  // Provide Blocs
  getIt.registerFactory<PostsBloc>(() => PostsBloc(postsRepo: getIt()));
  getIt.registerLazySingleton<ADUPostBloc>(() => ADUPostBloc(getIt()));
}
