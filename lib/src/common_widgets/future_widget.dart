import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {
  final Future future;
  final Widget isLoading;
  final Widget Function(AsyncSnapshot data) hasData;
  final Widget Function(Object? error, StackTrace? stackTrace) hasError;

  const FutureWidget({
    super.key,
    required this.future,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return isLoading;
        }

        if (snapshot.hasData) {
          return hasData(snapshot);
        } else if (snapshot.hasError) {
          return hasError(snapshot.error, snapshot.stackTrace);
        } else {
          return isLoading;
        }
      },
    );
  }
}

