import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:ivybabay_api/annotation/api_collect.dart';
import 'package:ivybabay_api/annotation/api_extension.dart';
import 'package:mustache/mustache.dart';
import 'package:source_gen/source_gen.dart';

import 'api_generator.dart';
import 'api_util_tpl.dart';

class ApiExtensionGenerator extends GeneratorForAnnotation<ApiExtension> {
  String _extensionClsName;
  String _extensionOnClsName;
  String _key;

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation,
      BuildStep buildStep) {
    _extensionClsName = annotation.peek('className').stringValue;
    _extensionOnClsName = annotation.peek('on').stringValue;
    _key = annotation.peek('key').stringValue;
    if (ApiGenerator.functions.isEmpty && _key.isEmpty) {
      /// 单个注解类生成相应文件，不合并
      return null;
    }
    print('ApiExtensionGenerator _extensionClsName[$_extensionClsName]\n');

    Template tpl = Template(ApiUtilTpl.tpl);
    String content = tpl.renderString({
      'imports': _key.isEmpty ? ApiGenerator.imports : Collector.inst.importsMap[_key],
      'className': _extensionClsName,
      'targetClassName': _extensionOnClsName,
      'functions': _key.isEmpty ? ApiGenerator.functions : Collector.inst.functionsMap[_key],
    });

    if (_key.isNotEmpty) {
      Collector.inst.importsMap[_key]?.clear();
      Collector.inst.importsMap.remove(_key);
      Collector.inst.functionsMap[_key]?.clear();
      Collector.inst.functionsMap.remove(_key);
      Collector.inst.importMap[_key]?.clear();
      Collector.inst.importMap.remove(_key);
    }

    print('Collector.inst.functionsMap size : ${Collector.inst.functionsMap.length}\n');

    return content;
  }
}