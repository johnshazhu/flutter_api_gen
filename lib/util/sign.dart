import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:ivybabay_api/api/config/api_config.dart';

class Sign {
  static String sign(String deviceNo, String t) {
    var encoded = Uri.encodeQueryComponent(deviceNo);
    var str = 'deviceno=$encoded&t=$t|${ApiConfig.signStr}';
    return hex.encode(md5.convert(str.codeUnits).bytes);
  }
}