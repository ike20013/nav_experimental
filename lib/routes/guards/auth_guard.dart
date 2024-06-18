// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:navigation_experimental/routes/guards/consntants.dart';
// import 'package:navigation_experimental/routes/guards/redirect_builder.dart';

// /// Guard that navigates user from unauthorized routes to dashboard
// /// if the user is authenticated.
// final class RedirectIfAuthenticatedGuard extends Guard {
//   // matches login and signup routes
//   @override
//   Pattern get matchPattern => RegExp(r'^/(login|signup)$');

//   @override
//   String? redirect(BuildContext context, GoRouterState state) {
//     final bool auth = authStatus;

//     if (auth) {
//       return '/dashboard';
//     }

//     return null;
//   }
// }

// /// Guard that navigates user from authorized routes to login
// /// when their authentication status is unauthenticated.
// final class RedirectIfUnauthenticatedGuard extends Guard {
//   // matches dashboard and settings routes
//   @override
//   Pattern get matchPattern => RegExp(r'^/(login|signup)$');

//   @override
//   bool get invertRedirect => true;

//   @override
//   String? redirect(BuildContext context, GoRouterState state) {
//     final auth = authStatus;

//     if (!auth) {
//       return '/login';
//     }

//     return null;
//   }
// }