import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post.dart';
import 'api_constants.dart';
import 'logger_interceptor.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static ApiClient? _instance;

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  static ApiClient _getInstance() {
    if (_instance == null) {
      final dio = Dio()
        ..options.baseUrl = ApiConstants.baseUrl
        ..interceptors.add(LoggerInterceptor());
      _instance = ApiClient(
        dio,
        baseUrl: ApiConstants.baseUrl,
      );
    }
    return _instance!;
  }

  static ApiClient get instance => _getInstance();

  @GET(ApiConstants.posts)
  Future<List<Post>> getPostList();

  @GET(ApiConstants.detailsPost)
  Future<Post> getDetailsPost(@Path('id') int postId);

  @DELETE(ApiConstants.deletePost)
  Future<Post> deletePost(@Path('id') int postId);
}
