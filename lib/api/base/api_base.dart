import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ivybabay_api/api/config/api_config.dart';

class ApiUtils {
  static const String ACCEPT_HEADER = "application/json,text/plain,*/*";

  ApiUtils._() {
    ApiConfig.inst.init();
  }

  static final ApiUtils _instance = ApiUtils._();

  static ApiUtils get inst => _instance;

  static Dio _dioMall = getDio(true);
  static Dio _dioIvyBaby = getDio(false);
  static String _ut = '';
  
  static Future updateToken() {
    Dio dio = getDefaultDio();
    return dio.post(ApiConfig.tokenUrl, data: {'token': _ut});
  }

  static Dio getDefaultDio() {
    Dio result = Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));

    final adapter = result.httpClientAdapter as DefaultHttpClientAdapter;
    adapter.onHttpClientCreate = (client) {
      if ((ApiConfig.proxy ?? '').isNotEmpty) {
        client.findProxy = (uri) {
          return 'PROXY ${ApiConfig.proxy}';
        };
      }

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    return result;
  }

  static Dio getDio(bool checkToken) {
    Dio dio = getDefaultDio();
    if (checkToken) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print('send request：path:${options.path}，baseURL:${options.baseUrl}');
        if ((_ut ?? '').isEmpty) {
          dio.lock();
          return updateToken().then((value) {
            _ut = value.data['ut'];
            options.headers['Cookie'] = 'ut=$_ut';
            return options;
          }).whenComplete(() => dio.unlock());
        } else {
          options.headers['Cookie'] = 'ut=$_ut';
          return options;
        }
      }, onError: (DioError error) {
        return error;
      }));
    }
    return dio;
  }

  Dio getDioByPath(String path) {
    if (path != null && path.startsWith(ApiConfig.base)) {
      return _dioIvyBaby;
    }

    return _dioMall;
  }

  Future<Response> get(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        String contentType = Headers.jsonContentType,
        String accept = ACCEPT_HEADER,
      }) async {
    if (!checkUrl(path)) {
      return null;
    }
    Future<Response> rsp = getDioByPath(path).get(path,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: accept,
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
        String accept = ACCEPT_HEADER,
      }) async {
    if (!checkUrl(path)) {
      return null;
    }
    Future<Response> rsp = getDioByPath(path).post(path,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: accept,
          },
          contentType: contentType,
        ),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    return rsp;
  }

  bool checkUrl(String path) {
    if ((path ?? '').startsWith('/')) {
      print('invalid url : $path, please check base or mallBase in assets/config.json');
      return false;
    }
    return true;
  }
}