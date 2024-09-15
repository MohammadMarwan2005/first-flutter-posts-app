import 'package:clean_architecture_posts_app/feature/posts/presentation/di/provid_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/posts/presentation/bloc/getposts/posts_bloc.dart';
import 'feature/posts/presentation/bloc/post_details/adu_post_bloc.dart';
import 'feature/posts/presentation/screens/add_posts_screen.dart';
import 'feature/posts/presentation/screens/post_details_screen.dart';
import 'feature/posts/presentation/screens/posts_screen.dart';

main() async {
  // Learned: Learn this:
  WidgetsFlutterBinding.ensureInitialized();

  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<PostsBloc>()),
          BlocProvider(create: (context) => getIt<ADUPostBloc>())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: const PostsScreen(),
          routes: {
            "PostsScreen": (_) => const PostsScreen(),
            "PostDetailsScreen": (_) => const PostDetailsScreen(),
            "AddPostScreen": (_) => const AddPostScreen()
          },
        ));
  }
}
