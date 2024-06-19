import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class OfficePage extends StatelessWidget {
//   final StatefulNavigationShell officeNavigationShell;
//   final List<Widget> children;

//   const OfficePage({
//     super.key,
//     required this.officeNavigationShell,
//     required this.children,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//       length: children.length,
//       initialIndex: officeNavigationShell.currentIndex,
//       child: Builder(
//         builder: (context) {
//           final tabController = DefaultTabController.of(context);

//           tabController.index = officeNavigationShell.currentIndex;

//           tabController.addListener(() {
//             if (tabController.indexIsChanging) {
//               officeNavigationShell.goBranch(
//                 tabController.index,
//                 initialLocation: tabController.index == officeNavigationShell.currentIndex,
//               );
//             }
//           });

//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               bottom: TabBar(
//                 controller: tabController,
//                 tabs: const [
//                   Icon(Icons.abc),
//                   Icon(Icons.ac_unit),
//                 ],
//               ),
//             ),
//             body: TabBarView(children: children),
//           );
//         },
//       ),
//     );
//   }
// }

class OfficePage extends StatefulWidget {
  final StatefulNavigationShell officeNavigationShell;
  final List<Widget> children;

  const OfficePage({
    super.key,
    required this.officeNavigationShell,
    required this.children,
  });

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final Map<String, ScrollController> _scrollControllers;

  @override
  void initState() {
    super.initState();

    _scrollControllers = {};
    const int initCategory = 0;

    if (initCategory == -1) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {});
    }

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initCategory != -1 ? initCategory : 0,
    )..addListener(() {
        if (!_tabController.indexIsChanging) {
          log('${_tabController.index}');

          final uriCategory =
              GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

          // final int index = widget.categories.indexWhere((c) => c == uriCategory);

          // if (index != _tabController.index) {
          //   _goRouterUpdateCategory(widget.categories[_tabController.index]);
          // }
        }
      });
  }

  @override
  void didUpdateWidget(covariant OfficePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_tabController.indexIsChanging) {
      final uriCategory =
          GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

      // final int index = widget.categories.indexWhere((c) => c == uriCategory);

      // if (index != -1 && index != _tabController.index) {
      //   log('update');
      //   _tabController.animateTo(index);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationShell = widget.officeNavigationShell;
    final children = widget.children;

    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [],
        body: const TabBarView(
          children: [
            // Tab1
            SizedBox(),
            // Tab 2
            SizedBox()
          ],
        ));
  }
}
