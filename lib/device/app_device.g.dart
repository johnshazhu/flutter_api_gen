// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDevice _$AppDeviceFromJson(Map<String, dynamic> json) {
  return AppDevice()
    ..appCode = json['appcode'] as String
    ..osType = json['ostype'] as int
    ..osVer = json['osversion'] as String
    ..clientVer = json['clientversion'] as String
    ..loginType = json['loginType'] as String
    ..channel = json['channel'] as String
    ..skin = json['yxyskin'] as String
    ..userId = json['userID'] as int
    ..token = json['token'] as String
    ..uuid = json['deviceuuid'] as String
    ..accountId = json['accountId'] as String
    ..deviceNo = json['deviceno'] as String
    ..t = json['t'] as int
    ..sign = json['sign'] as String
    ..gestation = json['hgestation'] as int
    ..premature = json['prematureOpen'] as int
    ..expectedDate = json['expectedDate'] as String
    ..birthday = json['birthday'] as String;
}

Map<String, dynamic> _$AppDeviceToJson(AppDevice instance) => <String, dynamic>{
      'appcode': instance.appCode,
      'ostype': instance.osType,
      'osversion': instance.osVer,
      'clientversion': instance.clientVer,
      'loginType': instance.loginType,
      'channel': instance.channel,
      'yxyskin': instance.skin,
      'userID': instance.userId,
      'token': instance.token,
      'deviceuuid': instance.uuid,
      'accountId': instance.accountId,
      'deviceno': instance.deviceNo,
      't': instance.t,
      'sign': instance.sign,
      'hgestation': instance.gestation,
      'prematureOpen': instance.premature,
      'expectedDate': instance.expectedDate,
      'birthday': instance.birthday,
    };
