class ApiExtension {
  /// 生成的扩展类名
  final String className;
  /// 基于扩展的类名
  final String on;
  /// 代表baseUrl, 非空时表示包含该域名注解类, 其中接口会合并到一个文件中
  final String key;
  const ApiExtension({
    this.className = 'ApiExtensionGen',
    this.on = 'ApiUtils',
    this.key = ''});
}