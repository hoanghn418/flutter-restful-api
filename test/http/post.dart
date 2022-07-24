import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(
      // JSON String to a map
      json.decode(str).map(
            // Serialize map to a object
            (x) => Post.fromJson(x),
          ),
    );

// Encode to JSON String
String postToJson(List<Post> data) => json.encode(
      List<dynamic>.from(
        data.map(
          // Deserialize object to a map
          (x) => x.toJson(),
        ),
      ),
    );

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
