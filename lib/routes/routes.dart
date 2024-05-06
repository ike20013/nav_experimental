import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/routes/transition.dart';
import 'package:navigation_experimental/screens/details_screen.dart';
import 'package:navigation_experimental/screens/home_screen.dart';

const String homeScreenRoute = 'home';
const String detailsScreenRoute = 'details';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: homeScreenRoute,
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        // MaterialPage(child: child)
        GoRoute(
          path: 'details/:id',
          name: detailsScreenRoute,
          pageBuilder: (context, state) => MyMaterialPage(
            backRouteName: '123',
            child: DetailsScreen(
              id: int.parse(state.pathParameters['id']!),
              isChatOpened: state.uri.queryParameters.containsKey('chat'),
              messageId: state.uri.queryParameters['messageId'],
            ),
            name: '123',
          ),
          // pageBuilder: (context, state) => MyTransitionPage(
          //   backRouteName: '/home',
          //   transitionDuration: const Duration(milliseconds: 200),
          // child: DetailsScreen(
          //   id: int.parse(state.pathParameters['id']!),
          //   isChatOpened: state.uri.queryParameters.containsKey('chat'),
          //   messageId: state.uri.queryParameters['messageId'],
          // ),
          // ),
          // pageBuilder: (context, state) => CustomTransitionPage<void>(
          //   key: state.pageKey,
          //   opaque: false,
          //   barrierDismissible: true,
          // child: DetailsScreen(
          //   id: int.parse(state.pathParameters['id']!),
          //   isChatOpened: state.uri.queryParameters.containsKey('chat'),
          //   messageId: state.uri.queryParameters['messageId'],
          // ),
          //   transitionsBuilder:
          //       (context, animation, secondaryAnimation, child) {
          //     final slideAnimation = Tween<Offset>(
          //       begin: const Offset(1, 0.0),
          //       end: const Offset(0, 0.0),
          //     ).animate(animation);

          //     return Stack(
          //       children: <Widget>[
          //         GestureDetector(
          //           behavior: HitTestBehavior.translucent,
          //           onTapUp: (_) => context.go('/home'),
          //           child: FadeTransition(
          //             opacity:
          //                 Tween<double>(begin: 0.0, end: 1).animate(animation),
          //             child: Container(
          //               color: Colors.black.withOpacity(0.5),
          //               constraints: const BoxConstraints.expand(),
          //             ),
          //           ),
          //         ),
          //         Align(
          //           alignment: Alignment.centerRight,
          //           child: SlideTransition(
          //             position: slideAnimation,
          //             child: child,
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          //   transitionDuration: const Duration(milliseconds: 200),
          // ),
        ),
        // GoRoute(
        //   name: detailsScreenRoute,
        //   path: 'details/:id',
        //   builder: (context, state) => DetailsScreen(
        //     id: int.parse(state.pathParameters['id']!),
        //   ),
        // )
      ],
    ),
  ],
);
class MyTransitionPage<T> extends CustomTransitionPage<T> {
  final String backRouteName;

  MyTransitionPage({
    required super.child,
    required this.backRouteName,
    super.transitionDuration,
    super.reverseTransitionDuration,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              _transitionsBuilder(
            context,
            animation,
            secondaryAnimation,
            child,
            backRouteName,
          ),
          opaque: false,
          barrierDismissible: true,
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    String backRouteName,
  ) {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(animation);

    return Stack(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: (_) => context.go(backRouteName),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1).animate(animation),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              constraints: const BoxConstraints.expand(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        ),
      ],
    );
  }
}

class CustomCupertinoPage extends CupertinoPage {
  final Widget child;
  final String name;

  CustomCupertinoPage({required this.name, required this.child})
      : super(key: ValueKey(name), child: child);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      opaque: false,
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0.0),
          end: const Offset(0, 0.0),
        ).animate(animation);

        return Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapUp: (_) => context.goNamed('home'),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1).animate(animation),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  constraints: const BoxConstraints.expand(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            ),
          ],
        );
        ;
      },
    );
  }
}
// class MyMaterialPage<T> extends MaterialPage<T> with MaterialRouteTransitionMixin<T> {
//   final String backRouteName;

//   MyMaterialPage({
//     required Widget child,
//     required this.backRouteName,
//     Duration? transitionDuration,
//     Duration? reverseTransitionDuration,
//     String? name,
//     Object? arguments,
//     String? restorationId,
//     LocalKey? key,
//   }) : super(
//     child: child,
//     transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
//     reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
//     name: name,
//     arguments: arguments,
//     restorationId: restorationId,
//     key: key,
//   );

//   @override
//   Widget buildContent(BuildContext context) {
//     return child;
//   }

//   @override
//   Route<T> createRoute(BuildContext context) {
//     return PageRouteBuilder<T>(
//       settings: this,
//       pageBuilder: (context, animation, secondaryAnimation) => buildContent(context),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return _transitionsBuilder(context, animation, secondaryAnimation, child, backRouteName);
//       },
//       transitionDuration: transitionDuration,
//       reverseTransitionDuration: reverseTransitionDuration,
//     );
//   }

//   static Widget _transitionsBuilder(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//     String backRouteName,
//   ) {
//     final slideAnimation = Tween<Offset>(
//       begin: const Offset(1, 0.0),
//       end: const Offset(0, 0.0),
//     ).animate(animation);

//   }

// }