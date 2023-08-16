# flutter_api_gen
pubspec.yaml中添加相关配置信息:<br/>
dependencies下添加<br/>
```
  ivybaby_api: ^0.1.3
  json_annotation: ^4.8.1
  analyzer: ^5.13.0
  source_gen: ^1.3.2
  mustache_template: ^2.0.0
  dio: ^5.3.2
  crypto: ^3.0.3
```
dev_dependencies下添加<br/>
```
  json_serializable: ^6.6.2
  build_runner: ^2.3.3
```
flutter下添加<br/>
```
assets:
    - assets/config.json
```
config.json基本内容：<br/>
```
{
  "base" : "https://www.test1.com",
  "mallBase" : "https://www.test2.com",
  "tokenUrl" : "/ouser-services/token/thirdLogin",
  "proxy" : "",
  "signStr" : ""
}
```

Api注解：<br/>
&ensp;&ensp;&ensp;&ensp;用于修饰类或者抽象方法<br/>
```
/// import 'package:ivybaby_api_example/config/app_config.dart';
/// import 'package:ivybaby_api/api/config/api_config.dart';
/// import 'package:ivybaby_api/api/base/api_base.dart';
//@Api('\${ApiConfig.mallBase}', target: 'CmsApiImpl')
@Api('\${ApiConfig.mallBase}', mergeByBaseUrl: false)
abstract class CmsApi {
  @Api('/cms/page/module/queryModulePromotion.do', data: {
    'itemsPerPage': 10,
    'companyId': '@C_AppConfig.COMPANY_ID',
    'lang': 'zh_CN',
    'platformId': '@C_AppConfig.PLATFORM_ID'
  }, method: Api.GET)
  Future<QueryModuleRsp> queryModuleData(int moduleId);
}
```
修饰类时：<br/>
&ensp;&ensp;&ensp;&ensp;url：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;定义接口的baseUrl<br/>
&ensp;&ensp;&ensp;&ensp;target：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;设置时，表示当前注解类下使用Api注解的方法的实现，会生成在一单独文件中，生成类名为target。<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;这种情况下不需要再使用ApiExtension来注解生成文件。<br/>
&ensp;&ensp;&ensp;&ensp;mergeByBaseUrl：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;结合注解ApiExtension中的配置使用。<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;true 表示使用Api注解的方法的实现，会按baseUrl分类，合并在统一的文件中，<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;文件类名由ApiExtension中配置。<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;target和mergeByBaseUrl都未设置时，表示使用Api注解的方法的实现，<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;生成在一个统一的文件中，不区分baseUrl。<br/>
修饰抽象方法时：<br/>
&ensp;&ensp;&ensp;&ensp;url：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;定义接口path<br/>
&ensp;&ensp;&ensp;&ensp;method：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;定义请求方式 get/post<br/>  
&ensp;&ensp;&ensp;&ensp;data：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;定义请求数据<br/>
&ensp;&ensp;&ensp;&ensp;contentType：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;请求contentType<br/>
&ensp;&ensp;&ensp;&ensp;header：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;请求header<br/>
其中 /// 部分为要导入的包，解析注解时未能找到好的自动导入包方式，暂时通过添加到文档注释中，以解析文档注释的方式来导入。
data中出现的'@C_xxx'样式的字符串，是为了能在生成的代码中保留原始代码片段，在注解处理时做的特殊处理，一些常量或者方法调用
都可以以那样的方式来处理<br/>

ApiExtension注解：<br/>
&ensp;&ensp;&ensp;&ensp;用于定义生成的接口所在文件相关信息，只用于修饰类，不适用于修饰方法。<br/>
&ensp;&ensp;&ensp;&ensp;className：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;生成文件的类名<br/>
&ensp;&ensp;&ensp;&ensp;key：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;配合Api中的mergeByBaseUrl使用，设置为baseUrl，生成接口实现文件时按key分类<br/>
&ensp;&ensp;&ensp;&ensp;on：<br/>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;基于扩展的类名，默认为ApiUtils   <br/>
```
// 所有@Api注解的方法，生成在一个文件中，类名为ApiImpls
@ApiExtension(className: 'ApiImpls')
class ExtensionApi {

}

// 以@Api中的baseUrl和key匹配为原则，匹配注解类下的方法，合并在一个文件中，文件类名为className
@ApiExtension(className: 'MallApiImpls', key: '\${ApiConfig.mallBase}')
class MallApis {

}
```
具体使用可参考example