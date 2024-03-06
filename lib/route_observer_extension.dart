import 'package:flutter/material.dart';

class RouteObserverExtension extends NavigatorObserver {
  String? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    currentRoute = route.settings.name;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    currentRoute = newRoute?.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    currentRoute = previousRoute?.settings.name;
  }
}