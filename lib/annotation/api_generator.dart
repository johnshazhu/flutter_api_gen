import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutter_api_test/annotation/api_generator_annotation.dart';
import 'package:mustache/mustache.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_util.dart';
import 'api_util_tpl.dart';

List<Map<String, dynamic>> functions = [];
List<Map<String, dynamic>> imports = [];
Map<String, bool> importMap = {};

class ApiGenerator extends GeneratorForAnnotation<ApiGen> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    String baseUrl = '';
    if (element is ClassElement) {
      baseUrl = annotation.peek('url')?.stringValue ?? '';
      print('ClassElement baseUrl : ' + baseUrl);
      if (baseUrl.isEmpty) {
        print('please check annotation url of class : ' + element.name);
        return;
      }
    }

    addDocumentImport(element, buildStep);

    element.visitChildren(SimpleVisitor(buildStep, baseUrl));

    Template tpl = Template(ApiUtilTpl.tpl);
    String content = tpl.renderString({
      'imports': imports,
      'className': annotation.peek('target')?.stringValue,
      'targetClassName': 'ApiBase',
      'functions': functions,
    });
    imports.clear();
    functions.clear();
    importMap.clear();
    return content;
  }

  static void addDocumentImport(Element element, BuildStep buildStep) {
    if (element.documentationComment != null) {
      List<String> comments = element.documentationComment.split('\n');
      for (String elem in comments) {
        if (elem?.isNotEmpty ?? false) {
          if (elem.contains('package:')) {
            ApiGenerator.addImport(
                buildStep, elem.substring(elem.indexOf('package')));
          } else if (elem.contains('dart:')) {
            ApiGenerator.addImport(
                buildStep, elem.substring(elem.indexOf('dart')));
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
    }
    if (!importMap.containsKey(result)) {
      importMap[result] = true;
      print("addImport path[$path]");
      imports.add({"path": result});
    }
  }
}

class SimpleVisitor extends SimpleElementVisitor {
  String _baseUrl;
  BuildStep _buildStep;
  SimpleVisitor(this._buildStep, this._baseUrl);

  @override
  visitMethodElement(MethodElement element) {
    ConstantReader reader = ConstantReader(TypeChecker.fromRuntime(ApiGen).firstAnnotationOf(element));
    if (reader == null) {
      print('firstAnnotationOf ' + element.name + ' is null');
      return;
    }

    Map<String, dynamic> funcInfo = {};
    Map<String, dynamic> defaultParams = {};

    funcInfo['functionDefine'] = element.toString();

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

    funcInfo["withBodyWrapper"] = false;
    ApiGenerator.addDocumentImport(element, _buildStep);

    var requestName = reader.peek('requestName')?.stringValue ?? '';
    var method = reader.peek('method')?.stringValue ?? '';
    switch (method) {
      case ApiGen.POST:
        requestName = 'post';
        funcInfo['httpSendData'] = true;
        break;

      case ApiGen.GET:
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
    });
    funcInfo["params"] = params;

    /// 函数参数有默认值的情况，更新函数定义
    if (defaultParams.isNotEmpty) {
      Iterator<String> iterator = defaultParams.keys.iterator;
      String funcDef = element.toString();
      while (iterator.moveNext()) {
        String key = iterator.current;
        funcDef = funcDef.replaceFirst(key, key + ' = ' + defaultParams[key]);
      }
      funcInfo["functionDefine"] = funcDef;
    }

    /// 函数返回值
    DartType returnType = element.returnType;
    funcInfo["returnType"] = returnType.toString();

    /// 返回值为泛型
    if (AnnotationUtil.canHaveGenerics(returnType)) {
      List<DartType> types = AnnotationUtil.getGenericTypes(returnType);
      if (types.length > 1) {
        throw Exception("multiple generics not support!!!");
      }
      funcInfo["rspType"] = types.first.toString();
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
    functions.add(funcInfo);
  }
}