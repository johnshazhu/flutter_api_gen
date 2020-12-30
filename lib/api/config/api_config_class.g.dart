// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiConfigInfo _$ApiConfigInfoFromJson(Map<String, dynamic> json) {
  return ApiConfigInfo()
    ..base = json['base'] as String
    ..ivyBase = json['ivyBase'] as String
    ..mallBase = json['mallBase'] as String
    ..tokenUrl = json['tokenUrl'] as String
    ..proxy = json['proxy'] as String
    ..signStr = json['signStr'] as String;
}

Map<String, dynamic> _$ApiConfigInfoToJson(ApiConfigInfo instance) =>
    <String, dynamic>{
      'base': instance.base,
      'ivyBase': instance.ivyBase,
      'mallBase': instance.mallBase,
      'tokenUrl': instance.tokenUrl,
      'proxy': instance.proxy,
      'signStr': instance.signStr,
    };
