import 'package:ivybabay_api/api/base/base_response.dart';

abstract class MallResponse<T> extends BaseResponse<T> {
  MallResponse(): super();

  String message;

  String errMsg;

  dynamic error;

  String getErrorMessage() => errMsg ?? message;
}