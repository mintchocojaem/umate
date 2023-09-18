import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey? key;

  ExceptionHandler._({
    this.printError = true,
    this.onException,
    this.key,
  }) {
    addHandler();
  }

  static ExceptionHandler? _instance;

  factory ExceptionHandler({
    bool printError = true,
    OnException? onException,
    GlobalKey? key,
  }) =>
      _instance ??= ExceptionHandler._(
        printError: printError,
        onException: onException,
        key: key,
      );

  void addHandler() {
    //If flutter throws an error
    FlutterError.onError = (details) {
      if (printError) {
        if (kDebugMode) {
          print(details.exception);
        }else{
          if (key?.currentContext != null) {
            onException?.call(details.exception.toString());
          }
        }
      }
    };
    //If invokeMethod throws an error
    PlatformDispatcher.instance.onError = (Object error, StackTrace? stack) {
      if (printError) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
      if (key?.currentContext != null) {
        onException?.call(error.toString());
      }
      return true;
    };
  }
}
