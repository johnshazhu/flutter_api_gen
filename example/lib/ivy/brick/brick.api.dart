import 'package:ivybaby_api/annotation/api_generator_annotation.dart';

import 'identity_verify.dart';

/// import 'dart:convert';
/// import 'package:ivybaby_api/api/base/api_base.dart';
/// import 'package:ivybaby_api/api/config/api_config.dart';
/// import 'package:ivybaby_api/api/config/global_data.dart';
//@Api('\${ApiConfig.base}', target: 'BrickApiImpl')
@Api('\${ApiConfig.base}', mergeByBaseUrl: false)
abstract class BrickApi {
  @Api('/api/json/brick/identityAuth', data: {
    'keyType': 1,
    'base': '@C_ApiConfig.base'
  })
  Future<IdentityVerifyRsp> identityAuth(String idCardNo, String name);
}