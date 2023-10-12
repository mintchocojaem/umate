import 'package:flutter/foundation.dart';

class ExceptionDto {
  final String code;
  final String message;

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }

  const ExceptionDto({
    this.code = "ServerConnectionError",
    this.message = "서버 연결에 문제가 발생했어요.",
  });
}

typedef OnException = void Function(String message);

class ExceptionHandler {
  final bool printError;
  final OnException? onException;

  ExceptionHandler._({
    this.printError = true,
    this.onException,
  }) {
    addHandler();
  }

  static ExceptionHandler? _instance;

  factory ExceptionHandler({
    bool printError = true,
    OnException? onException,
  }) =>
      _instance ??= ExceptionHandler._(
        printError: printError,
        onException: onException,
      );

  void addHandler() {
    //If flutter throws an error
    FlutterError.onError = (details) {
      if (printError) {
        if (kDebugMode) {
          print(details.exception);
          print(details.stack);
        }
        //onException?.call(details.exception.toString());
      }
    };
    //If invokeMethod throws an error
    PlatformDispatcher.instance.onError = (Object error, StackTrace? stack) {
      if (printError) {
        if (kDebugMode) {
          print(error.toString());
          print(stack);
        }
      }
      onException?.call(error.toString());
      return true;
    };
  }

  void invokeException(String message){
    if (printError) {
      if (kDebugMode) {
        print(message);
      }
    }
    onException?.call(message);
  }

}
