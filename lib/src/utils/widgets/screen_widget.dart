import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnInitScreen = void Function(BuildContext context);
typedef OnDisposeScreen = void Function(BuildContext context);
typedef ScreenWidgetBuilder = Widget Function(
  BuildContext context,
  ScreenManager screenManager,
);

class ScreenManager {
  final List<CancelToken> _cancelTokens = [];

  CancelToken newCancelToken() {
    final cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);
    return cancelToken;
  }

  void cancelToken(CancelToken cancelToken) {
    _cancelTokens.remove(cancelToken);
    cancelToken.cancel();
  }

  void dispose() {
    for (var cancelToken in _cancelTokens) {
      cancelToken.cancel();
    }
  }
}

class ScreenWidget extends ConsumerStatefulWidget {
  final Widget Function(BuildContext context, ScreenManager screenManager)
      builder;
  final OnInitScreen? onInitScreen;
  final OnDisposeScreen? onDisposeScreen;
  final ScreenManager screenManager;

  const ScreenWidget({
    super.key,
    required this.builder,
    this.onInitScreen,
    this.onDisposeScreen,
    required this.screenManager,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends ConsumerState<ScreenWidget> {
  @override
  void initState() {
    widget.onInitScreen?.call(context);
    super.initState();
  }

  @override
  void dispose() {
    widget.screenManager.dispose();
    widget.onDisposeScreen?.call(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.screenManager);
  }
}
