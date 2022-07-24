import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'post.dart';

final logger = Logger();

// test restful APIs
void main() {
  group('#test GET request', () {
    test('#test get all posts', () async {
      // tạo GET request
      String url = 'https://jsonplaceholder.typicode.com/posts';
      final response = await http.get(Uri.parse(url));
      // data sample trả về trong response
      Map<String, String> headers = response.headers;
      String? contentType = headers['content-type'];
      int statusCode = response.statusCode;
      String json = response.body;
      // Thực hiện convert json to list object...
      List<Post> postList = postFromJson(json);

      logger.i('''
  content type: $contentType
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  status code: $statusCode
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  json string body: $json
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  list size: ${postList.length}
  ''');

      expect(response.statusCode, 200);
    });

    test('#test get details post', () async {
      // tạo GET request
      String url = 'https://jsonplaceholder.typicode.com/posts/1';
      final response = await http.get(Uri.parse(url));
      // data sample trả về trong response
      Map<String, String> headers = response.headers;
      String? contentType = headers['content-type'];
      int statusCode = response.statusCode;
      String json = response.body;
      // Thực hiện convert json to object...
      Post post = Post.fromJson(jsonDecode(json));

      logger.i('''
  content type: $contentType
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  status code: $statusCode
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  json string body: $json
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  parse this JSON data:
  id: ${post.id}
  title: ${post.title}
  body: ${post.body}
  userId: ${post.userId}
  ''');

      expect(response.statusCode, 200);
    });
  });

  group('#test POST request', () {
    test('#test create post', () async {
      // cài đặt tham số POST request
      String url = 'https://jsonplaceholder.typicode.com/posts';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"title": "Hello", "body": "body text", "userId": 1}';
      // tạo POST request
      final response =
          await http.post(Uri.parse(url), headers: headers, body: json);
      // kiểm tra status code của kết quả response
      int statusCode = response.statusCode;
      // API này trả về id của item mới được add trong body
      String body = response.body;
      // {
      //   "title": "Hello",
      //   "body": "body text",
      //   "userId": 1,
      //   "id": 101
      // }
      Post post = Post.fromJson(jsonDecode(body));

      logger.i('''
  status code: $statusCode
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  json string body: $body
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  parse this JSON data:
  id: ${post.id}
  title: ${post.title}
  body: ${post.body}
  userId: ${post.userId}
  ''');

      expect(response.statusCode, 201);
    });
  });

  group('#test PUT request', () {
    test('#test replace post', () async {
      // cài đặt tham số PUT request
      String url = 'https://jsonplaceholder.typicode.com/posts/1';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"title": "Hello", "body": "body text", "userId": 1}';
      // tạo PUT request
      final response =
          await http.put(Uri.parse(url), headers: headers, body: json);
      // kiểm tra status code của kết quả response
      int statusCode = response.statusCode;
      // API này trả về id của item được cập nhật
      String body = response.body;
      // {
      //   "title": "Hello",
      //   "body": "body text",
      //   "userId": 1,
      //   "id": 1
      // }
      Post post = Post.fromJson(jsonDecode(body));

      logger.i('''
  status code: $statusCode
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  json string body: $body
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  parse this JSON data:
  id: ${post.id}
  title: ${post.title}
  body: ${post.body}
  userId: ${post.userId}
  ''');

      expect(response.statusCode, 200);
    });
  });

  group('#test PATH request', () {
    test('#test edit post', () async {
      // cài đặt tham số PATCH request
      String url = 'https://jsonplaceholder.typicode.com/posts/1';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"title": "Hello"}';
      // tạo PATCH request
      final response =
          await http.patch(Uri.parse(url), headers: headers, body: json);
      // kiểm tra status code của kết quả response
      int statusCode = response.statusCode;
      // chỉ có title là được update
      String body = response.body;
      // {
      //   "userId": 1,
      //   "id": 1
      //   "title": "Hello",
      //   "body": "quia et suscipit\nsuscipit recusandae... (body text cũ không đổi)",
      // }
      Post post = Post.fromJson(jsonDecode(body));

      logger.i('''
  status code: $statusCode
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  json string body: $body
  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
  parse this JSON data:
  id: ${post.id}
  title: ${post.title}
  body: ${post.body}
  userId: ${post.userId}
  ''');

      expect(response.statusCode, 200);
    });
  });

  group('#test DELETE request', () {
    test('#test delete post', () async {
      // post 1
      String url = 'https://jsonplaceholder.typicode.com/posts/1';
      // tạo DELETE request
      final response = await http.delete(Uri.parse(url));
      // kiểm tra status code của kết quả response
      int statusCode = response.statusCode;

      logger.i('''
  status code: $statusCode
  ''');

      expect(response.statusCode, 200);
    });
  });
}
