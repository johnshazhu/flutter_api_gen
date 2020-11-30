import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'api_config.dart';

class ApiBase {
  ApiBase._();

  static final ApiBase _instance = ApiBase._();

  static ApiBase get inst => _instance;

  static Dio _dio = getDio(true);
  static Dio _dio2 = getDio(false);

  static Dio getDefaultDio() {
    Dio result = Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));

    final adapter = result.httpClientAdapter as DefaultHttpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.211.36:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    return result;
  }

  static Dio getDio(bool base) {
    Dio dio = getDefaultDio();
    if (base) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print('send request：path:${options.path}，baseURL:${options.baseUrl}');

      }, onError: (DioError error) {
        return error;
      }));
    }
    return dio;
  }

  Dio getDioByPath(String path) {
    if (path != null && path.startsWith(ApiConfig.base)) {
      return _dio;
    }

    return _dio2;
  }

  Future<Response> get(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        String contentType = Headers.jsonContentType,
      }) async {
    Future<Response> rsp = getDioByPath(path).get(path,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: "application/json,text/plain,*/*",
          },
          contentType: contentType,
        ),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    return rsp;
  }

  Future<Response> post(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        String contentType = Headers.formUrlEncodedContentType,
      }) async {
    Future<Response> rsp = getDioByPath(path).post(path,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: "application/json,text/plain,*/*",
          },
          contentType: contentType,
        ),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    return rsp;
  }
}