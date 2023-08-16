import 'package:ivybaby_api/annotation/api_generator_annotation.dart';

import 'page/query_module.dart';

/// import 'dart:convert';
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
  Future<QueryModuleRsp> queryModuleData(int? moduleId);
}