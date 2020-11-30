import 'package:flutter_api_test/annotation/api_generator_annotation.dart';

import 'get_app_page.dart';

/// package:flutter_api_test/api/api_base.dart
/// package:flutter_api_test/api/api_config.dart
@ApiGen('\${ApiConfig.base}', target: 'TestApi')
abstract class ApiInterface {
  /// package:flutter_api_test/api/base/constants.dart
  @ApiGen('/cms/page/getAppPage', data: {
    'platformId' : '@C_Constants.PLATFORM_ID'
  })
  Future<GetPageRsp> getAppPage1(int pageType, {String pageId});
}