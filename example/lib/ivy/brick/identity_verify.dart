import 'package:ivybaby_api/api/base/base_ivybaby_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'identity_verify.g.dart';

@JsonSerializable()
class IdentityVerifyRsp extends IvyBabyResponse<IdentityVerifyRspData> {
  IdentityVerifyRsp() : super();

  factory IdentityVerifyRsp.fromJson(Map<String, dynamic> json) => _$IdentityVerifyRspFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityVerifyRspToJson(this);
}

@JsonSerializable()
class IdentityVerifyRspData {
  IdentityVerifyRspData() : super();

  String msg;

  bool result;

  factory IdentityVerifyRspData.fromJson(Map<String, dynamic> json) => _$IdentityVerifyRspDataFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityVerifyRspDataToJson(this);
}