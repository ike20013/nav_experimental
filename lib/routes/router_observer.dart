import 'dart:developer';

import 'package:flutter/material.dart';

class MyNavObserver extends NavigatorObserver {
  /// Creates a [MyNavObserver].

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}