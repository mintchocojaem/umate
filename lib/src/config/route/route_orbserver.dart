part of 'router_provider.dart';

class RouteObServer extends NavigatorObserver {

  final Ref ref;

  RouteObServer(this.ref);

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    if (kDebugMode) {
      print('Route Observer > didPop : ${route.settings.name}');
    }
    _cancelAllRequest();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('Route Observer > didPush : ${route.settings.name}');
    }
    _cancelAllRequest();
    super.didPush(route, previousRoute);
  }

  _cancelAllRequest() {
    final dioClient = ref.read(dioClientProvider);
    dioClient.cancelAllRequests();
  }
}