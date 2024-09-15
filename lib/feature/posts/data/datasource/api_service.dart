import 'dart:convert';

import 'package:clean_architecture_posts_app/feature/core/errorhandling/Exception.dart';
import 'package:clean_architecture_posts_app/feature/posts/data/datamodel/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

// Learned: in data sources, you don't need to use Either, because they will throw an exception if something went wrong
// we use Either only in the domain functions, so we don't deal with exceptions there...

abstract class APIService {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const String BASE_URL = "https://jsonplaceholder.typicode.com";

class APIServiceImpl implements APIService {
  final http.Client client;

  APIServiceImpl(this.client);

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode / 100 == 2) {
      final List jsonList = jsonDecode(response.body) as List;
      final List<PostModel> result = jsonList
          .map<PostModel>((s) => PostModel.fromJson(s)).toList();
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.post(Uri.parse("$BASE_URL/posts"), body: body);
    if (response.statusCode == 201) {
        return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response =
        await client.delete(Uri.parse("$BASE_URL/posts/$id"));
    if (response.statusCode== 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = postModel.toJson();
    final response =
        await client.patch(Uri.parse("$BASE_URL/posts/${postModel.id}"), body: body);
    if (response.statusCode== 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
