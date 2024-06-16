import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/routes/guards/consntants.dart';
import 'package:navigation_experimental/routes/guards/redirect_builder.dart';

final class RedirectIfNoAccessGuard extends Guard {
  // matches dashboard and settings routes
  @override
  Pattern get matchPattern => RegExp(r'^/(news)');

  @override
  bool get invertRedirect => false;

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    if (!hasNewsAccess) {
      print('NO ACCESS');
      return '/home';
    }

    return null;
  }
}
