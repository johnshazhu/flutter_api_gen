import 'dart:convert';

import 'package:ivybaby_api/device/app_device.dart';
import 'package:ivybaby_api/util/sign.dart';

class GlobalData {
  static AppDevice appDevice = AppDevice.inst;

  static String updateBody(String content) {
    Map<String, dynamic>? map = json.decode(content);
    if (map != null) {
      Map<String, dynamic>? appDeviceMap = map['appDevice'];
      if (appDeviceMap != null) {
        appDeviceMap['t'] = DateTime.now().millisecondsSinceEpoch;
        appDeviceMap['sign'] = Sign.sign(appDevice.deviceNo, appDeviceMap['t'].toString());
      }
    }
    return json.encode(map);
  }
}