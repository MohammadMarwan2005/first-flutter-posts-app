import 'package:clean_architecture_posts_app/feature/posts/domain/domainmodel/post.dart';

class PostModel extends Post {
  const PostModel({required super.userId,
    required super.id,
    required super.title,
    required super.body});

  factory PostModel.fromJson(Map<String, dynamic> jsonMap) {
    return PostModel(
        userId: jsonMap["userId"],
        id: jsonMap["id"],
        title: jsonMap["title"],
        body: jsonMap["body"]);
  }

  Map<String, dynamic> toJson() {
    return {"userId": userId.toString(), "id": id.toString(), "title": title, body: body};
  }

}
