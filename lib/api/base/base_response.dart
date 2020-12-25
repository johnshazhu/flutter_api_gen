abstract class BaseResponse<T> {
  BaseResponse();

  dynamic code;

  T data;

  bool get isSuccess => '0' == code?.toString();

  bool get isEmpty => data == null;
}