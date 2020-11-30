// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPageRsp _$GetPageRspFromJson(Map<String, dynamic> json) {
  return GetPageRsp()
    ..code = json['code']
    ..message = json['message'] as String
    ..errMsg = json['errMsg'] as String
    ..data = json['data'] == null
        ? null
        : GetPageRspData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetPageRspToJson(GetPageRsp instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errMsg': instance.errMsg,
      'data': instance.data,
    };

GetPageRspData _$GetPageRspDataFromJson(Map<String, dynamic> json) {
  return GetPageRspData()
    ..dataList = (json['dataList'] as List)
        ?.map((e) => e == null
            ? null
            : DataListClass.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfoClass.fromJson(json['pageInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetPageRspDataToJson(GetPageRspData instance) =>
    <String, dynamic>{
      'dataList': instance.dataList,
      'pageInfo': instance.pageInfo,
    };

DataListClass _$DataListClassFromJson(Map<String, dynamic> json) {
  return DataListClass()
    ..templateCode = json['templateCode'] as String
    ..templateName = json['templateName'] as String
    ..templateSubName = json['templateSubName']
    ..templateTitle = json['templateTitle']
    ..dataType = json['dataType'] as int
    ..staticData = json['staticData'] == null
        ? null
        : StaticDataClass.fromJson(json['staticData'] as Map<String, dynamic>)
    ..moduleId = json['moduleId'] as int
    ..moduleData = json['moduleData'];
}

Map<String, dynamic> _$DataListClassToJson(DataListClass instance) =>
    <String, dynamic>{
      'templateCode': instance.templateCode,
      'templateName': instance.templateName,
      'templateSubName': instance.templateSubName,
      'templateTitle': instance.templateTitle,
      'dataType': instance.dataType,
      'staticData': instance.staticData,
      'moduleId': instance.moduleId,
      'moduleData': instance.moduleData,
    };

StaticDataClass _$StaticDataClassFromJson(Map<String, dynamic> json) {
  return StaticDataClass()
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : ImagesClass.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..bgColor = json['bgColor'] as String
    ..bkImg = json['bkImg'] as String;
}

Map<String, dynamic> _$StaticDataClassToJson(StaticDataClass instance) =>
    <String, dynamic>{
      'images': instance.images,
      'bgColor': instance.bgColor,
      'bkImg': instance.bkImg,
    };

ImagesClass _$ImagesClassFromJson(Map<String, dynamic> json) {
  return ImagesClass()
    ..oriHeight = json['oriHeight'] as String
    ..oriWidth = json['oriWidth'] as String
    ..beginDate = json['beginDate'] as int
    ..endDate = json['endDate'] as int
    ..src = json['src'] as String
    ..link = json['link'] == null
        ? null
        : LinkClass.fromJson(json['link'] as Map<String, dynamic>)
    ..url = json['url'] as String
    ..desc = json['desc'] as String
    ..status = json['status'] as int;
}

Map<String, dynamic> _$ImagesClassToJson(ImagesClass instance) =>
    <String, dynamic>{
      'oriHeight': instance.oriHeight,
      'oriWidth': instance.oriWidth,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'src': instance.src,
      'link': instance.link,
      'url': instance.url,
      'desc': instance.desc,
      'status': instance.status,
    };

LinkClass _$LinkClassFromJson(Map<String, dynamic> json) {
  return LinkClass()
    ..data = json['data'] == null
        ? null
        : GetPageRspData.fromJson(json['data'] as Map<String, dynamic>)
    ..type = json['type'] as String
    ..appData = json['appData'] as String
    ..status = json['status'] as bool;
}

Map<String, dynamic> _$LinkClassToJson(LinkClass instance) => <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
      'appData': instance.appData,
      'status': instance.status,
    };

PageInfoClass _$PageInfoClassFromJson(Map<String, dynamic> json) {
  return PageInfoClass()
    ..id = json['id'] as int
    ..pageCode = json['pageCode']
    ..pageVer = json['pageVer']
    ..startDate = json['startDate'] as int
    ..endDate = json['endDate'] as int
    ..name = json['name'] as String
    ..displayTitle = json['displayTitle'] as String
    ..keywords = json['keywords']
    ..description = json['description']
    ..cmsThemeId = json['cmsThemeId'] as int
    ..status = json['status'] as int
    ..cmsThemeStyle = json['cmsThemeStyle']
    ..customStyle = json['customStyle']
    ..createTime = json['createTime'] as int
    ..updateTime = json['updateTime'] as int
    ..companyId = json['companyId'] as int
    ..platform = json['platform']
    ..showSections = json['showSections'] as int
    ..brandId = json['brandId']
    ..merchantId = json['merchantId']
    ..channelCode =
        (json['channelCode'] as List)?.map((e) => e as String)?.toList()
    ..mediaId = json['mediaId']
    ..moduleList = json['moduleList']
    ..promotionIdList = json['promotionIdList']
    ..cmsPlatformVOList = (json['cmsPlatformVOList'] as List)
        ?.map((e) => e == null
            ? null
            : CmsPlatformVOListClass.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cmsPageSectionsHeaderVO = json['cmsPageSectionsHeaderVO']
    ..cmsPageSectionsTailVO = json['cmsPageSectionsTailVO']
    ..cmsPageSectionsNavigationVO = json['cmsPageSectionsNavigationVO']
    ..bgImg = json['bgImg'] as String
    ..bgRepeat = json['bgRepeat'] as int
    ..bgColor = json['bgColor'] as String
    ..cartListUrl = json['cartListUrl']
    ..shipFeeNote = json['shipFeeNote']
    ..shareTitle = json['shareTitle']
    ..shareImg = json['shareImg']
    ..shareDesc = json['shareDesc']
    ..coverImage = json['coverImage']
    ..type = json['type'] as int
    ..previewUrl = json['previewUrl']
    ..headBgImg = json['headBgImg'] as String
    ..headBgColor = json['headBgColor'] as String;
}

Map<String, dynamic> _$PageInfoClassToJson(PageInfoClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageCode': instance.pageCode,
      'pageVer': instance.pageVer,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'name': instance.name,
      'displayTitle': instance.displayTitle,
      'keywords': instance.keywords,
      'description': instance.description,
      'cmsThemeId': instance.cmsThemeId,
      'status': instance.status,
      'cmsThemeStyle': instance.cmsThemeStyle,
      'customStyle': instance.customStyle,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'companyId': instance.companyId,
      'platform': instance.platform,
      'showSections': instance.showSections,
      'brandId': instance.brandId,
      'merchantId': instance.merchantId,
      'channelCode': instance.channelCode,
      'mediaId': instance.mediaId,
      'moduleList': instance.moduleList,
      'promotionIdList': instance.promotionIdList,
      'cmsPlatformVOList': instance.cmsPlatformVOList,
      'cmsPageSectionsHeaderVO': instance.cmsPageSectionsHeaderVO,
      'cmsPageSectionsTailVO': instance.cmsPageSectionsTailVO,
      'cmsPageSectionsNavigationVO': instance.cmsPageSectionsNavigationVO,
      'bgImg': instance.bgImg,
      'bgRepeat': instance.bgRepeat,
      'bgColor': instance.bgColor,
      'cartListUrl': instance.cartListUrl,
      'shipFeeNote': instance.shipFeeNote,
      'shareTitle': instance.shareTitle,
      'shareImg': instance.shareImg,
      'shareDesc': instance.shareDesc,
      'coverImage': instance.coverImage,
      'type': instance.type,
      'previewUrl': instance.previewUrl,
      'headBgImg': instance.headBgImg,
      'headBgColor': instance.headBgColor,
    };

CmsPlatformVOListClass _$CmsPlatformVOListClassFromJson(
    Map<String, dynamic> json) {
  return CmsPlatformVOListClass()
    ..objType = json['objType'] as int
    ..objId = json['objId'] as int
    ..platform = json['platform'] as int;
}

Map<String, dynamic> _$CmsPlatformVOListClassToJson(
        CmsPlatformVOListClass instance) =>
    <String, dynamic>{
      'objType': instance.objType,
      'objId': instance.objId,
      'platform': instance.platform,
    };
