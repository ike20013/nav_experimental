import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/main_page.dart';
import 'package:navigation_experimental/routes/router_observer.dart';
import 'package:navigation_experimental/routes/transition.dart';
import 'package:navigation_experimental/screens/details/details_screen.dart';
// import 'package:navigation_experimental/screens/details_screen.dart';
import 'package:navigation_experimental/screens/home_screen.dart';
import 'package:navigation_experimental/screens/library/library/library.dart';
import 'package:navigation_experimental/screens/library/library_details/library_details.dart';
import 'package:navigation_experimental/screens/office/documents_details_page.dart';
import 'package:navigation_experimental/screens/office/documents_page.dart';
import 'package:navigation_experimental/screens/office/office_page.dart';
import 'package:navigation_experimental/screens/office/tasks_page.dart';

const String homeScreenRoute = 'home';
const String detailsScreenRoute = 'details';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _officeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'office');

final shellRouter = GoRouter(
  observers: [MyNavObserver()],
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      // parentNavigatorKey: _mainNavigatorKey,
      builder: (context, state, navigationShell) => MainPage(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          // navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              name: homeScreenRoute,
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'details/:id',
                  name: detailsScreenRoute,
                  onExit: (context, state) async {
                    log('dreamly popped');

                    return true;
                  },
                  pageBuilder: (context, state) => MyMaterialPage(
                    // backRouteName: '/home',
                    // transitionDuration: const Duration(milliseconds: 200),
                    child: DetailsScreen(
                      id: int.parse(state.pathParameters['id']!),
                      isChatOpened: state.uri.queryParameters.containsKey('chat'),
                      messageId: state.uri.queryParameters['messageId'],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'library',
              path: '/library',
              builder: (context, state) => const LibraryPage(),
              routes: [
                GoRoute(
                  path: 'library_details',
                  name: 'library_details',
                  onExit: (context, state) async {
                    log('dreamly popped');

                    return true;
                  },
                  builder: (context, state) => const LibraryDetails(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/office/documents',
          navigatorKey: _officeNavigatorKey,
          routes: [
            GoRoute(
              name: 'office',
              path: '/office',
              builder: (context, state) => const Scaffold(),
              routes: [
                StatefulShellRoute(
                  parentNavigatorKey: _officeNavigatorKey,
                  builder: (context, state, officeNavigationShell) => officeNavigationShell,
                  navigatorContainerBuilder: (context, officeNavigationShell, children) =>
                      OfficePage(
                    officeNavigationShell: officeNavigationShell,
                    children: children,
                  ),
                  branches: [
                    StatefulShellBranch(
                      routes: [
                        GoRoute(
                          path: 'documents',
                          name: 'documents',
                          onExit: (context, state) async {
                            log('dreamly popped');

                            return true;
                          },
                          builder: (context, state) => const DocumentsPage(),
                          routes: [
                            GoRoute(
                              parentNavigatorKey: _officeNavigatorKey,
                              path: 'documents_details',
                              name: 'documents_details',
                              onExit: (context, state) async {
                                log('dreamly popped');

                                return true;
                              },
                              builder: (context, state) => const DocumentsDetailsPage(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    StatefulShellBranch(
                      routes: [
                        GoRoute(
                          path: 'tasks',
                          name: 'tasks',
                          onExit: (context, state) async {
                            log('dreamly popped');

                            return true;
                          },
                          builder: (context, state) => const TasksPage(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: homeScreenRoute,
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:id',
          name: detailsScreenRoute,
          onExit: (context, state) async {
            log('dreamly popped');

            return true;
          },
          pageBuilder: (context, state) => MyMaterialPage(
            // backRouteName: '/home',
            // transitionDuration: const Duration(milliseconds: 200),
            child: DetailsScreen(
              id: int.parse(state.pathParameters['id']!),
              isChatOpened: state.uri.queryParameters.containsKey('chat'),
              messageId: state.uri.queryParameters['messageId'],
            ),
          ),
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
