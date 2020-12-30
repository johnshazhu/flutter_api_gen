import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'api_config_class.dart';

class ApiConfig {
  ApiConfig._() {
    loadConfig().then((value) {
      print('ApiConfig loadConfig : $value');
      if ((value ?? '').isNotEmpty) {
        ApiConfigInfo config = ApiConfigInfo.fromJson(json.decode(value));
        base = config?.base;
        ivyBase = config?.ivyBase;
        mallBase = config?.mallBase;
        tokenUrl = '$mallBase${config?.tokenUrl}';
        proxy = config?.proxy;
        signStr = config?.signStr;
        print('base : $base\n');
        print('ivyBase : $ivyBase\n');
        print('mallBase : $mallBase\n');
      }
    });
  }

  static final ApiConfig _instance = ApiConfig._();

  static ApiConfig get inst => _instance;

  void init() {
    print('ApiConfig init');
  }

  static String base = '';
  static String ivyBase = '';
  static String mallBase = '';
  static String tokenUrl = '';
  static String proxy = '';
  static String signStr = '';

  Future<String> loadConfig() async {
    return await rootBundle.loadString('assets/config.json');
  }
}