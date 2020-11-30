class ApiGen {
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String PATCH = 'PATCH';
  static const String DELETE = 'DELETE';

  final String url;
  final String method;
  final dynamic data;
  final String contentType;
  final Map<String, dynamic> header;
  final String requestName;
  final String target;

  const ApiGen(this.url, {
    this.method = POST,
    this.data,
    this.contentType,
    this.header,
    this.requestName,
    this.target
  });
}