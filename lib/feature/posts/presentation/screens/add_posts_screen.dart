import 'package:clean_architecture_posts_app/feature/posts/presentation/bloc/post_details/adu_post_bloc.dart';
import 'package:clean_architecture_posts_app/feature/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domainmodel/post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Add a post"),
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
                    FilledButton(
                        onPressed: () {
                          final post = Post(
                              userId: 34334,
                              id: 102,
                              title: titleController.text,
                              body: bodyController.text);
                          context.read<ADUPostBloc>().add(AddPostEvent(post));
                        },
                        child: const Text("Add Post"))
                  ],
                );
              } else if (aduState is SuccessState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  const snackBar = SnackBar(
                      backgroundColor: Colors.SuccessContainerColor,
                      content: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Added Successfully!",
                          style:
                              TextStyle(color: Colors.onSuccessContainerColor),
                        ),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                titleController.text = "";
                bodyController.text = "";
                context.read<ADUPostBloc>().add(ResetEvent());
                return const Text("Success");
              } else if (aduState is FailureState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  final snackBar = getErrorSnackBarInstance(message: aduState.message, context: context);
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

InputDecoration getCustomTextFieldDecoration(String hintText) =>
    InputDecoration(
      hintText: hintText,
      hintStyle:
          const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
      filled: true,
      fillColor: const Color(0x1d8fde8c),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );

SnackBar getErrorSnackBarInstance({required String message, required BuildContext context}) {
  return SnackBar(
      backgroundColor:
      Theme.of(context).colorScheme.errorContainer,
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(message,
            style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onErrorContainer)),
      ));
}