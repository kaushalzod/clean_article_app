import 'package:article_app/core/constant/network_const.dart';
import 'package:dio/dio.dart';

class DioClient {
  DioClient._privateConstructor();

  static DioClient? _instance;
  static DioClient get instance =>
      _instance ??= DioClient._privateConstructor();

  static BaseOptions options = BaseOptions(
    baseUrl: NetworkConst.baseURL,
    connectTimeout: NetworkConst.connectionTimeout,
    receiveTimeout: NetworkConst.recieveTimeout,
    contentType: Headers.jsonContentType,
    validateStatus: (status) => true,
    responseType: ResponseType.json,
  );

  final Dio _dio = Dio(options);

  /// Get api call
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }
}
