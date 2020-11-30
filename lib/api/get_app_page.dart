import 'package:flutter_api_test/api/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_app_page.g.dart';

@JsonSerializable()
class GetPageRsp extends BaseResponse<GetPageRspData> {
  GetPageRsp() : super();

  factory GetPageRsp.fromJson(Map<String, dynamic> json) => _$GetPageRspFromJson(json);

  Map<String, dynamic> toJson() => _$GetPageRspToJson(this);
}

@JsonSerializable()
class GetPageRspData {
  GetPageRspData();

  List<DataListClass> dataList;

  PageInfoClass pageInfo;

  factory GetPageRspData.fromJson(Map<String, dynamic> json) => _$GetPageRspDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetPageRspDataToJson(this);
}

@JsonSerializable()
class DataListClass {
  DataListClass() : super();

  String templateCode;

  String templateName;

  dynamic templateSubName;

  dynamic templateTitle;

  int dataType;

  StaticDataClass staticData;

  int moduleId;

  dynamic moduleData;

  factory DataListClass.fromJson(Map<String, dynamic> json) => _$DataListClassFromJson(json);

  Map<String, dynamic> toJson() => _$DataListClassToJson(this);
}

@JsonSerializable()
class StaticDataClass {
  StaticDataClass() : super();

  List<ImagesClass> images;

  String bgColor;

  String bkImg;

  factory StaticDataClass.fromJson(Map<String, dynamic> json) => _$StaticDataClassFromJson(json);

  Map<String, dynamic> toJson() => _$StaticDataClassToJson(this);
}

@JsonSerializable()
class ImagesClass {
  ImagesClass() : super();

  String oriHeight;

  String oriWidth;

  int beginDate;

  int endDate;

  String src;

  LinkClass link;

  String url;

  String desc;

  int status;

  factory ImagesClass.fromJson(Map<String, dynamic> json) => _$ImagesClassFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesClassToJson(this);
}

@JsonSerializable()
class LinkClass {
  LinkClass() : super();

  GetPageRspData data;

  String type;

  String appData;

  bool status;

  factory LinkClass.fromJson(Map<String, dynamic> json) => _$LinkClassFromJson(json);

  Map<String, dynamic> toJson() => _$LinkClassToJson(this);
}

@JsonSerializable()
class PageInfoClass {
  PageInfoClass() : super();

  int id;

  dynamic pageCode;

  dynamic pageVer;

  int startDate;

  int endDate;

  String name;

  String displayTitle;

  dynamic keywords;

  dynamic description;

  int cmsThemeId;

  int status;

  dynamic cmsThemeStyle;

  dynamic customStyle;

  int createTime;

  int updateTime;

  int companyId;

  dynamic platform;

  int showSections;

  dynamic brandId;

  dynamic merchantId;

  List<String> channelCode;

  dynamic mediaId;

  dynamic moduleList;

  dynamic promotionIdList;

  List<CmsPlatformVOListClass> cmsPlatformVOList;

  dynamic cmsPageSectionsHeaderVO;

  dynamic cmsPageSectionsTailVO;

  dynamic cmsPageSectionsNavigationVO;

  String bgImg;

  int bgRepeat;

  String bgColor;

  dynamic cartListUrl;

  dynamic shipFeeNote;

  dynamic shareTitle;

  dynamic shareImg;

  dynamic shareDesc;

  dynamic coverImage;

  int type;

  dynamic previewUrl;

  String headBgImg;

  String headBgColor;

  factory PageInfoClass.fromJson(Map<String, dynamic> json) => _$PageInfoClassFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoClassToJson(this);
}

@JsonSerializable()
class CmsPlatformVOListClass {
  CmsPlatformVOListClass() : super();

  int objType;

  int objId;

  int platform;

  factory CmsPlatformVOListClass.fromJson(Map<String, dynamic> json) => _$CmsPlatformVOListClassFromJson(json);

  Map<String, dynamic> toJson() => _$CmsPlatformVOListClassToJson(this);
}
