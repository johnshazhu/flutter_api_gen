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
      Response rsp = await {{requestName}}(
          "{{{url}}}",
          {{#hasData}}{{#httpSendData}}data{{/httpSendData}}{{^httpSendData}}queryParameters{{/httpSendData}}: data,{{/hasData}}
          {{#hasContentType}}contentType: "{{{contentType}}}",{{/hasContentType}});
      {{#withBodyWrapper}}
      return {{{rspType}}}.fromJson(json.decode(rsp.data));
      {{/withBodyWrapper}}
      
      {{^withBodyWrapper}}
      return {{{rspType}}}.fromJson(rsp.data);
      {{/withBodyWrapper}}
    });
    return result;
  }
  {{/functions}}
}
""";
}