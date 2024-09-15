import 'package:clean_architecture_posts_app/feature/posts/presentation/bloc/post_details/adu_post_bloc.dart';
import 'package:clean_architecture_posts_app/feature/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domainmodel/post.dart';
import 'add_posts_screen.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context)?.settings.arguments as Post;
    titleController.text = post.title;
    bodyController.text = post.body;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Delete-Update a post"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(56),
            child: BlocBuilder<ADUPostBloc, ADUPostState>(
                builder: (context, aduState) {
              if (aduState is ADUInitial) {
                return Column(
                  children: [
                    TextField(
                      decoration: getCustomTextFieldDecoration(
                        "Title",
                      ),
                      controller: titleController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: getCustomTextFieldDecoration("body"),
                      controller: bodyController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context)
                                        .colorScheme
                                        .errorContainer)),
                            onPressed: () {
                              context
                                  .read<ADUPostBloc>()
                                  .add(DeletePostEvent(post.id));
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer),
                            )),
                        const SizedBox(
                          width: 32,
                        ),
                        FilledButton(
                            onPressed: () {
                              final post = Post(
                                  userId: 34334,
                                  id: 102,
                                  title: titleController.text,
                                  body: bodyController.text);
                              context
                                  .read<ADUPostBloc>()
                                  .add(UpdatePostEvent(post));
                            },
                            child: const Text("Update"))
                      ],
                    )
                  ],
                );
              } else if (aduState is SuccessState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  var snackBar = SnackBar(
                      backgroundColor: Colors.SuccessContainerColor,
                      content: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          aduState.message,
                          style:
                              const TextStyle(color: Colors.onSuccessContainerColor),
                        ),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                context.read<ADUPostBloc>().add(ResetEvent());
                return const Text("Success");
              } else if (aduState is FailureState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  final snackBar = getErrorSnackBarInstance(
                      message: aduState.message, context: context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                return ProperErrorMessage(
                  message: aduState.message,
                  onRetry: () {
                    final post = Post(
                        userId: 34334,
                        id: 102,
                        title: titleController.text,
                        body: bodyController.text);
                    context.read<ADUPostBloc>().add(AddPostEvent(post));
                  },
                );
              } else if (aduState is IsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ProperErrorMessage(
                  message: "Something Went Wrong!",
                  onRetry: () {
                    final post = Post(
                        userId: 34334,
                        id: 102,
                        title: titleController.text,
                        body: bodyController.text);
                    context.read<ADUPostBloc>().add(AddPostEvent(post));
                  },
                );
              }
            })));
  }
}
