import 'package:flutter/material.dart';

import 'future_widget.dart';

class FutureListWidget<T> extends StatelessWidget {
  final Future<List<T>> futureList;
  final Widget isLoading;
  final Widget Function(T item) hasData;
  final Widget hasEmptyData;
  final Widget Function(Object? error, StackTrace? stackTrace) hasError;

  const FutureListWidget({
    super.key,
    required this.futureList,
    required this.isLoading,
    required this.hasData,
    required this.hasEmptyData,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      future: futureList,
      isLoading: isLoading,
      hasData: (snapshot) {
        if (snapshot.data.isEmpty) {
          return hasEmptyData;
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return hasData(snapshot.data[index]);
          },
        );
      },
      hasError: (error, stackTrace) {
        return hasError(error, stackTrace);
      },
    );
  }
}
