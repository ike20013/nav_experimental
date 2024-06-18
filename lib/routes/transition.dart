// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class MyMaterialPage<T> extends Page<T> {
//   /// Creates a material page.
//   const MyMaterialPage({
//     required this.child,
//     this.maintainState = true,
//     this.fullscreenDialog = false,
//     this.allowSnapshotting = true,
//     super.key,
//     super.name,
//     super.arguments,
//     super.restorationId,
//   });

//   /// The content to be shown in the [Route] created by this page.
//   final Widget child;

//   /// {@macro flutter.widgets.ModalRoute.maintainState}
//   final bool maintainState;

//   /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
//   final bool fullscreenDialog;

//   /// {@macro flutter.widgets.TransitionRoute.allowSnapshotting}
//   final bool allowSnapshotting;

//   @override
//   Route<T> createRoute(BuildContext context) {
//     return _MyPageBasedMaterialPageRoute<T>(page: this, allowSnapshotting: allowSnapshotting);
//   }
// }

// // A page-based version of MaterialPageRoute.
// //
// // This route uses the builder from the page to build its content. This ensures
// // the content is up to date after page updates.
// class _MyPageBasedMaterialPageRoute<T> extends PageRoute<T> with MyMaterialRouteTransitionMixin<T> {
//   _MyPageBasedMaterialPageRoute({
//     required MyMaterialPage<T> page,
//     super.allowSnapshotting,
//   }) : super(settings: page);

//   MyMaterialPage<T> get _page => settings as MyMaterialPage<T>;

//   @override
//   Widget buildContent(BuildContext context) {
//     return _page.child;
//   }

//   @override
//   bool get maintainState => _page.maintainState;

//   @override
//   bool get fullscreenDialog => _page.fullscreenDialog;

//   @override
//   String get debugLabel => '${super.debugLabel}(${_page.name})';
// }

// mixin MyMaterialRouteTransitionMixin<T> on PageRoute<T> {
//   /// Builds the primary contents of the route.
//   @protected
//   Widget buildContent(BuildContext context);

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);

//   @override
//   Color? get barrierColor => null;

//   @override
//   String? get barrierLabel => null;

//   @override
//   bool get opaque => false;

//   @override
//   bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
//     // Don't perform outgoing animation if the next route is a fullscreen dialog.
//     return (nextRoute is MaterialRouteTransitionMixin && !nextRoute.fullscreenDialog) ||
//         (nextRoute is CupertinoRouteTransitionMixin && !nextRoute.fullscreenDialog);
//   }

//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     final Widget result = buildContent(context);
//     return Semantics(
//       scopesRoute: true,
//       explicitChildNodes: true,
//       child: result,
//     );
//   }

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     final slideAnimation = Tween<Offset>(
//       begin: const Offset(1, 0.0),
//       end: const Offset(0, 0.0),
//     ).animate(animation);

//     if (MediaQuery.sizeOf(context).width >= 900) {
//       return Stack(
//         children: <Widget>[
//           GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTapUp: (_) => context.goNamed('home'),
//             child: FadeTransition(
//               opacity: Tween<double>(begin: 0.0, end: 1).animate(animation),
//               child: Container(
//                 color: Colors.black.withOpacity(0.5),
//                 constraints: const BoxConstraints.expand(),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: SlideTransition(
//               position: slideAnimation,
//               child: child,
//             ),
//           ),
//         ],
//       );
//     }

//     final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
//     return theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
//   }
// }
