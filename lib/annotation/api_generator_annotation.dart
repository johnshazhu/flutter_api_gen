class Api {
  static const String GET = 'GET';
  static const String POST = 'POST';

  /// 注解修饰类时url为baseUrl, 修饰接口时url为path
  final String url;
  final String method;
  final dynamic data;
  final String contentType;
  final Map<String, dynamic> header;
  final String requestName;
  /// 注解修饰类时用, 表示要生成的类名, 设置时修饰类下的接口会生成在指定的类中
  final String target;
  /// 注解修饰类时用, 表示生成接口是否按域名合并到文件中
  final bool mergeByBaseUrl;

  const Api(this.url, {
    this.method = POST,
    this.data,
    this.contentType,
    this.header,
    this.requestName,
    this.target,
    this.mergeByBaseUrl = false
  });
}