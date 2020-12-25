import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'app_device.g.dart';

@JsonSerializable()
class AppDevice {
  @JsonKey(name: 'appcode')
  var appCode = Platform.isAndroid ? 'YUXY' : '20000';

  @JsonKey(name: 'ostype')
  var osType = Platform.isAndroid ? 2 : 1;

  @JsonKey(name: 'osversion')
  var osVer = '';

  @JsonKey(name: 'clientversion')
  var clientVer = '';

  var loginType = '0';

  var channel = 'official';

  @JsonKey(name: 'yxyskin')
  var skin = '0';

  @JsonKey(name: 'userID')
  var userId = 0;

  var token = '';

  @JsonKey(name: 'deviceuuid')
  var uuid = '';

  var accountId = '';

  @JsonKey(name: 'deviceno')
  var deviceNo = '';

  var t = 0;

  var sign = '';

  @JsonKey(name: 'hgestation')
  var gestation = 1;

  @JsonKey(name: 'prematureOpen')
  var premature = 0;

  var expectedDate = '';

  var birthday = '';

  AppDevice();

  AppDevice._();

  static final AppDevice _instance = AppDevice._();

  static AppDevice get inst => _instance;

  factory AppDevice.fromJson(Map<String, dynamic> json) =>
      _$AppDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$AppDeviceToJson(this);
}