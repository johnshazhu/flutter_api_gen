// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ApiGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:flutter_api_test/api/api_base.dart';
import 'package:flutter_api_test/api/api_config.dart';
import 'package:flutter_api_test/api/base/constants.dart';
import 'dart:async';
import 'package:flutter_api_test/api/get_app_page.dart';

extension TestApi on ApiBase {
  Future<GetPageRsp> getAppPage1(int pageType, {String pageId}) {
    Map<String, dynamic> data = {
      "platformId": Constants.PLATFORM_ID,
    };

    if (null != pageType) {
      data["pageType"] = pageType;
    }
    if (null != pageId) {
      data["pageId"] = pageId;
    }

    Future<GetPageRsp> result = new Future(() async {
      Response rsp = await post(
        "${ApiConfig.base}/cms/page/getAppPage",
        data: data,
      );

      return GetPageRsp.fromJson(rsp.data);
    });

    return result;
  }
}
