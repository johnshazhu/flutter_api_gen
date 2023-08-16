class ApiUtilTpl {
  static const String tpl = """
import 'package:dio/dio.dart';
{{#imports}}
import '{{{path}}}';
{{/imports}}
extension {{className}} on {{targetClassName}} {
  {{#functions}}
  {{{functionDefine}}} {
    {{#hasData}}
    {{{dataType}}} data = {{{dataValue}}};
    {{/hasData}}
    
    {{^withBodyWrapper}}
    {{#params}}
    if ({{paramName}} != null) {
      data["{{{paramName}}}"] = {{paramName}};
    }
    {{/params}}
    {{/withBodyWrapper}}
    
    {{{returnType}}} result = new Future(() async {
      Response? rsp = await {{requestName}}(
          "{{{url}}}",
          {{#hasData}}{{#httpSendData}}data{{/httpSendData}}{{^httpSendData}}queryParameters{{/httpSendData}}: data,{{/hasData}}
          {{#hasContentType}}contentType: "{{{contentType}}}",{{/hasContentType}});
      if (rsp?.data is String) {
        return {{{rspType}}}.fromJson(json.decode(rsp?.data));
      } else {
        return {{{rspType}}}.fromJson(rsp?.data);
      }
    });
    return result;
  }
  {{/functions}}
}
""";
}