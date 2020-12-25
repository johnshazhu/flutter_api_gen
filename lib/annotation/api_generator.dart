import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:ivybaby_api/annotation/api_collect.dart';
import 'package:mustache/mustache.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_util.dart';
import 'api_generator_annotation.dart';
import 'api_util_tpl.dart';

class ApiGenerator extends GeneratorForAnnotation<Api> {
  static List<Map<String, dynamic>> functions = [];
  static List<Map<String, dynamic>> imports = [];
  static Map<String, bool> importMap = {};
  static String baseUrl = '';
  static bool mergeByBaseUrl = false;

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation,
      BuildStep buildStep) {
    /// 注解修饰类时，检查是否注解了url作为baseUrl
    if (element is ClassElement) {
      baseUrl = annotation.peek('url')?.stringValue ?? '';
      print('ClassElement baseUrl : ' + baseUrl);
      if (baseUrl.isEmpty) {
        print('please check annotation url of class : ' + element.name);
        return;
      }
      mergeByBaseUrl = annotation.peek('mergeByBaseUrl').boolValue;
    }

    /// 添加document中的导入包信息，生成目标文件时要用到
    addDocumentImport(element, buildStep);

    element.visitChildren(SimpleVisitor(buildStep, baseUrl));

    print('\n==========${element.displayName}==========\n');
    return getGenerateContent(annotation);
  }

  String getGenerateContent(ConstantReader annotation) {
    String target = annotation.peek('target')?.stringValue ?? '';
    if (target.isNotEmpty) {
      /// 指定了生成目标类名，单独生成对应文件
      Template tpl = Template(ApiUtilTpl.tpl);
      String content = tpl.renderString({
        'imports': imports,
        'className': target,
        'targetClassName': 'ApiUtils',
        'functions': functions,
      });
      imports.clear();
      functions.clear();
      importMap.clear();
      return content;
    }
    /// 仅搜集注解信息，在extension注解中生成文件
    return null;
  }

  /// 解析注释中的import信息
  /// 简单处理规则->'import '开头，';'结尾的认为是import信息
  static void addDocumentImport(Element element, BuildStep buildStep) {
    if (element.documentationComment != null) {
      List<String> comments = element.documentationComment.split('\n');
      for (String elem in comments) {
        String info = elem ?? '';
        String prefix = 'import \'';
        String suffix = '\';';
        if (info.contains(prefix)) {
          info = info.substring(info.indexOf(prefix));
          if (info.startsWith(prefix) && info.endsWith(suffix)) {
            ApiGenerator.addImport(buildStep,
                info.substring(prefix.length, info.length - suffix.length));
          }
        }
      }
    }
  }

  static void addImport(BuildStep buildStep, String path) {
    String result = path;
    if (path.startsWith('/${buildStep.inputId.package}/lib/')) {
      result =
      "package:${buildStep.inputId.package}/${path.replaceFirst('/${buildStep.inputId.package}/lib/', '')}";
    } else if (path.startsWith(RegExp('/' + '${buildStep.inputId.package}' + r'/\w+?/lib/'))) {
      String prefix = '/${buildStep.inputId.package}/';
      String suffix = '/lib/';
      int start = path.indexOf(prefix) + prefix.length;
      int end = path.indexOf(suffix);
      result = 'package:${buildStep.inputId.package}_' + path.substring(start, end) + '/' + path.substring(end + suffix.length);
    }

    if (!mergeByBaseUrl) {
      if (!importMap.containsKey(result)) {
        importMap[result] = true;
        print("addImport path[$result]");
        imports.add({"path": result});
      }
      return;
    }

    Map<String, bool> map = Collector.inst.importMap[baseUrl];
    if (map == null) {
      map = Map<String, bool>();
      Collector.inst.importMap[baseUrl] = map;
    }
    if (!map.containsKey(result)) {
      map[result] = true;
      print("addImport path[$path]");
      List<Map<String, dynamic>> urlImports = Collector.inst.importsMap[baseUrl];
      if (urlImports == null) {
        urlImports = List<Map<String, dynamic>>();
        Collector.inst.importsMap[baseUrl] = urlImports;
      }
      urlImports.add({"path": result});
    }
  }
}

class SimpleVisitor extends SimpleElementVisitor {
  String _baseUrl;
  BuildStep _buildStep;
  SimpleVisitor(this._buildStep, this._baseUrl);

  @override
  visitMethodElement(MethodElement element) {
    ConstantReader reader = ConstantReader(TypeChecker.fromRuntime(Api).firstAnnotationOf(element));
    if (reader == null) {
      print('firstAnnotationOf ' + element.name + ' is null');
      return;
    }

    Map<String, dynamic> funcInfo = {};
    Map<String, dynamic> defaultParams = {};

    funcInfo['functionDefine'] = element.toString().replaceAll('*', '');

    if (element.returnType.isVoid) {
      print('please check return type of method : ' + element.name);
      return;
    }

    var url = reader.peek('url')?.stringValue ?? '';
    if (url.isEmpty) {
      print('please check annotation url of method : ' + element.name);
      return;
    }
    funcInfo['url'] = _baseUrl + url;

    funcInfo["withBodyWrapper"] = _baseUrl.contains('ApiConfig.base');
    ApiGenerator.addDocumentImport(element, _buildStep);
    Map<String, dynamic> map;
    if (funcInfo["withBodyWrapper"]) {
      funcInfo['hasData'] = true;
      funcInfo['dataType'] = 'Map<String, dynamic>';
      map = {};
      map['\"appDevice\"'] = 'GlobalData.appDevice';
    }

    var requestName = reader.peek('requestName')?.stringValue ?? '';
    var method = reader.peek('method')?.stringValue ?? '';
    switch (method) {
      case Api.POST:
        requestName = 'post';
        funcInfo['httpSendData'] = true;
        break;

      case Api.GET:
        requestName = 'get';
        funcInfo['httpSendData'] = false;
        break;

      default:
        print('unsupportable method : ' + method);
        return;
    }
    funcInfo['requestName'] = requestName;

    var data = reader.peek('data');
    funcInfo["hasData"] = data != null && data.objectValue != null;
    if (funcInfo["hasData"]) {
      funcInfo["dataType"] = AnnotationUtil.getDataType(data.objectValue);
      funcInfo["dataValue"] = AnnotationUtil.getDataValue(data.objectValue);
    } else {
      if ((element.parameters?.length ?? 0) > 0) {
        funcInfo["hasData"] = true;
        funcInfo["dataValue"] = "{}";
        funcInfo["dataType"] = "Map<String, dynamic>";
      }
    }

    /// 函数参数，收集有默认值的参数
    List<Map<String, String>> params = [];
    element.parameters?.forEach((parameterElement) {
      params.add({"paramName": parameterElement.displayName});
      if (parameterElement.defaultValueCode != null) {
        defaultParams[parameterElement.displayName] = parameterElement.defaultValueCode;
      }
      if (funcInfo["withBodyWrapper"]) {
        map['\"${parameterElement.displayName}\"'] = parameterElement.displayName;
      }
    });
    funcInfo["params"] = params;
    if (funcInfo["withBodyWrapper"]) {
      funcInfo['dataValue'] = {'\"body\"': 'json.encode($map)'};
    }
    /// 函数参数有默认值的情况，更新函数定义
    if (defaultParams.isNotEmpty) {
      // Iterator<String> iterator = defaultParams.keys.iterator;
      String funcDef = element.toString().replaceAll('*', '');
      // while (iterator.moveNext()) {
      //   String key = iterator.current;
      //   funcDef = funcDef.replaceFirst(key, key + ' = ' + defaultParams[key]);
      // }
      funcInfo["functionDefine"] = funcDef;
    }

    /// 函数返回值
    DartType returnType = element.returnType;
    funcInfo["returnType"] = returnType.toString().replaceAll('*', '');

    /// 返回值为泛型
    if (AnnotationUtil.canHaveGenerics(returnType)) {
      List<DartType> types = AnnotationUtil.getGenericTypes(returnType);
      if (types.length > 1) {
        throw Exception("multiple generics not support!!!");
      }
      funcInfo["rspType"] = types.first.toString().replaceAll('*', '');
    }

    /// http contentType
    funcInfo['hasContentType'] = reader.peek('contentType')?.stringValue != null;
    if (funcInfo['hasContentType']) {
      funcInfo['contentType'] = reader.peek('contentType')?.stringValue;
    }

    /// 获取此函数需要的引入的包
    /// 返回值的包
    ApiGenerator.addImport(_buildStep, returnType.element.librarySource.fullName);

    /// 返回值为泛型
    if (AnnotationUtil.canHaveGenerics(returnType)) {
      List<DartType> types = AnnotationUtil.getGenericTypes(returnType);
      for (DartType type in types) {
        ApiGenerator.addImport(_buildStep, type.element.librarySource.fullName);
      }
    }
    if (!ApiGenerator.mergeByBaseUrl) {
      ApiGenerator.functions.add(funcInfo);
    } else {
      List<Map<String, dynamic>> funcs = Collector.inst.functionsMap[_baseUrl];
      if (funcs == null) {
        funcs = List<Map<String, dynamic>>();
        Collector.inst.functionsMap[_baseUrl] = funcs;
      }
      funcs.add(funcInfo);
    }
  }
}