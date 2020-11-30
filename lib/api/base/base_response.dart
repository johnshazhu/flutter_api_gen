abstract class BaseResponse<T> {
  dynamic code;
  String message;
  String errMsg;
  T data;

  String get errorMessage => errMsg ?? message;

  bool get isSuccess => '0' == code?.toString();

  bool get isEmpty => data == null;
}