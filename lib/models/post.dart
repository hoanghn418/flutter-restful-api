import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

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

@JsonSerializable()
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

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
