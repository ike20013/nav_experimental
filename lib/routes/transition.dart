import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyMaterialPage<T> extends Page<T> {
  final String backRouteName;
  final Duration transitionDuration;

  /// Creates a material page.
  const MyMaterialPage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    required this.backRouteName,
    this.transitionDuration = const Duration(milliseconds: 200),
  }) : super();

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  /// {@macro flutter.widgets.TransitionRoute.allowSnapshotting}
  final bool allowSnapshotting;

  @override
  Route<T> createRoute(BuildContext context) {
    // return _MyPageBasedMaterialPageRoute(
    //               page: this, allowSnapshotting: allowSnapshotting);

      return CupertinoPageRoute(builder: (context) => child, settings: this);
    // return PageRouteBuilder<T>(
    //   settings: this,
    //   opaque: false,
    //   pageBuilder: (context, animation, secondaryAnimation) =>
    //       _MyPageBasedMaterialPageRoute(
    //               page: this, allowSnapshotting: allowSnapshotting)
    //           .buildContent(context),
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     return _transitionsBuilder(
    //         context, animation, secondaryAnimation, child, backRouteName);
    //   },
    //   transitionDuration: transitionDuration,
    //   // reverseTransitionDuration: reverseTransitionDuration,
    // );
  }

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
          onTapUp: (_) => context.goNamed(backRouteName),
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

  // @override
  // Route<T> createRoute(BuildContext context) {
  //   return _MyPageBasedMaterialPageRoute<T>(page: this, allowSnapshotting: allowSnapshotting);
  // }
}

class _MyPageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _MyPageBasedMaterialPageRoute({
    required MyMaterialPage<T> page,
    super.allowSnapshotting,
  }) : super(settings: page) {
    assert(opaque);
  }

  MyMaterialPage<T> get _page => settings as MyMaterialPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}