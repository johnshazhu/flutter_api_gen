import 'package:ivybaby_api/api/base/base_response.dart';

abstract class IvyBabyResponse<T> extends BaseResponse<T> {
  String? bscode;

  String? msg;

  dynamic userEnv;

  List<String>? routers;

  @override
  bool get isSuccess => 1 == code && ('1' == bscode || (bscode ?? '').isEmpty);

  bool get isBusinessError => 1 == code && ('1' != (bscode ?? '')) && ((msg ?? '').isNotEmpty);
}