import 'package:json_annotation/json_annotation.dart';
part 'api_config_class.g.dart';

@JsonSerializable()
class ApiConfigInfo {
  ApiConfigInfo();

  String base;

  String ivyBase;

  String mallBase;

  String tokenUrl;

  String proxy;

  String signStr;

  factory ApiConfigInfo.fromJson(Map<String, dynamic> json) =>
      _$ApiConfigInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ApiConfigInfoToJson(this);
}