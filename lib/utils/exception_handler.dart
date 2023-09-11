import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExceptionDto {
  final String code;
  final String message;

  const ExceptionDto(this.code, this.message);
}

typedef OnException = void Function(String message);

class ExceptionHandler {
  final bool printError;
  final OnException? onException;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  ExceptionHandler._({
    this.printError = true,
    this.onException,
    this.scaffoldMessengerKey,
  }) {
    addHandler();
  }

  static ExceptionHandler? _instance;

  factory ExceptionHandler({
    bool printError = true,
    OnException? onException,
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
  }) =>
      _instance ??= ExceptionHandler._(
        printError: printError,
        onException: onException,
        scaffoldMessengerKey: scaffoldMessengerKey,
      );

  void addHandler() {
    //If flutter throws an error
    FlutterError.onError = (details) {
      if (scaffoldMessengerKey?.currentContext != null) {
        onException?.call(details.exception.toString());
      }
      if (printError) {
        if (kDebugMode) {
          print(details.exception);
        }
      }
    };
    //If invokeMethod throws an error
    PlatformDispatcher.instance.onError = (Object error, StackTrace? stack) {
      final ExceptionDto exceptionDto = (error as ExceptionDto);
      if (scaffoldMessengerKey?.currentContext != null) {
        onException?.call(exceptionDto.message);
      }
      if (printError) {
        if (kDebugMode) {
          print('${exceptionDto.code} : ${exceptionDto.message}');
        }
      }
      return true;
    };
  }
}
