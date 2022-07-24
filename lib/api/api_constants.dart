class ApiConstants {
  const ApiConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _posts = '/posts';
  static const String posts = _posts;
  static const String detailsPost = '$_posts/{id}';
  static const String deletePost = '$_posts/{id}';
}
