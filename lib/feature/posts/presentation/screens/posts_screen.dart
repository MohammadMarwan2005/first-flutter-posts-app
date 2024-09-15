import 'package:clean_architecture_posts_app/feature/posts/presentation/screens/add_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/getposts/posts_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(const GetAllPostsEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Posts Clean Arch App"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, postsState) {
        if (postsState is LoadedPosts) {
          return RefreshIndicator(
              child: ListView.builder(
                  itemCount: postsState.posts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "PostDetailsScreen",
                            arguments: postsState.posts[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "${index + 1}: ${postsState.posts[index].title}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  postsState.posts[index].body,
                                  textAlign: TextAlign.start,
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(height: 1)
                          ],
                        ),
                      ),
                    );

                    // My Item...
                  }),
              onRefresh: () async {
                context.read<PostsBloc>().add(const RefreshEvent());
                return;
              });
        } else if (postsState is IsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (postsState is GetPostsFailureState) {
          return ProperErrorMessage(
            message: postsState.message,
            onRetry: () {
              context.read<PostsBloc>().add(const RefreshEvent());
            },
          );
        }
        return const Text("Something Went Wrong!");
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddPostScreen");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProperErrorMessage extends StatelessWidget {
  final String message;
  final Function onRetry;

  const ProperErrorMessage(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final snackBar = getErrorSnackBarInstance(message: message, context: context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: 8,
          ),
          FilledButton(onPressed: () {onRetry();}, child: const Text("Retry Again"))
        ],
      ),
    );
  }
}
