import 'package:ivybaby_api/api/base/base_mall_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'query_module.g.dart';

@JsonSerializable()
class QueryModuleRsp extends MallResponse<List<QueryModuleRspData>> {
  QueryModuleRsp() : super();

  factory QueryModuleRsp.fromJson(Map<String, dynamic>? json) => _$QueryModuleRspFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$QueryModuleRspToJson(this);
}

@JsonSerializable()
class QueryModuleRspData {
  QueryModuleRspData();

  int? promotionId;

  dynamic themeId;

  String? themeName;

  String? promPlatform;

  String? joinType;

  int? promType;

  String? userScope;

  int? contentType;

  int? status;

  List<String>? merchantNameList;

  int? startTime;

  int? endTime;

  String? promotionType;

  String? iconText;

  String? iconUrl;

  factory QueryModuleRspData.fromJson(Map<String, dynamic>? json) => _$QueryModuleRspDataFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$QueryModuleRspDataToJson(this);
}