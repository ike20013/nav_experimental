import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/screens/office/documents_page.dart';
import 'package:navigation_experimental/screens/office/tasks_page.dart';
import 'package:navigation_experimental/widgets/sliver_tab_bar.dart';

class OfficePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const OfficePage({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex,
    )..addListener(() {
        if (!_tabController.indexIsChanging) {
          if (_tabController.index != widget.navigationShell.currentIndex) {
            widget.navigationShell.goBranch(
              _tabController.index,
              initialLocation: _tabController.index == widget.navigationShell.currentIndex,
            );
          }
        }
      });
  }

  @override
  void didUpdateWidget(covariant OfficePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_tabController.indexIsChanging) {
      if (widget.navigationShell.currentIndex != _tabController.index) {
        _tabController.animateTo(widget.navigationShell.currentIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverTabBar(
                    tabs: const [
                      Tab(text: 'Documents'),
                      Tab(text: 'Tasks'),
                    ],
                    controller: _tabController,
                  ),
                ],
            body: TabBarView(
              controller: _tabController,
              children: const [
                // Tab1
                DocumentsPage(key: PageStorageKey('documents')),
                // Tab 2
                TasksPage(key: PageStorageKey('tasks'))
              ],
            ));
      },
    );
  }
}

// class OfficePage extends StatefulWidget {
//   const OfficePage({super.key});

//   @override
//   State<OfficePage> createState() => _OfficePageState();
// }

// class _OfficePageState extends State<OfficePage> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   late final Map<String, ScrollController> _scrollControllers;

//   @override
//   void initState() {
//     super.initState();

//     _scrollControllers = {};
//     const int initCategory = 0;

//     if (initCategory == -1) {
//       WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {});
//     }

//     _tabController = TabController(
//       length: 2,
//       vsync: this,
//       initialIndex: initCategory != -1 ? initCategory : 0,
//     )..addListener(() {
//         if (!_tabController.indexIsChanging) {
//           log('${_tabController.index}');

//           final uriCategory =
//               GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

//           // final int index = widget.categories.indexWhere((c) => c == uriCategory);

//           // if (index != _tabController.index) {
//           //   _goRouterUpdateCategory(widget.categories[_tabController.index]);
//           // }
//         }
//       });
//   }

//   @override
//   void didUpdateWidget(covariant OfficePage oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (!_tabController.indexIsChanging) {
//       final uriCategory =
//           GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

//       // final int index = widget.categories.indexWhere((c) => c == uriCategory);

//       // if (index != -1 && index != _tabController.index) {
//       //   log('update');
//       //   _tabController.animateTo(index);
//       // }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
    // return NestedScrollView(
    //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
    //           SliverTabBar(tabs: const [
    //             Tab(text: 'Documents'),
    //             Tab(text: 'Tasks'),
    //           ], controller: _tabController),
    //         ],
    //     body: TabBarView(
    //       controller: _tabController,
    //       children: const [
    //         // Tab1
    //         DocumentsPage(),
    //         // Tab 2
    //         TasksPage()
    //       ],
    //     ));
//   }
// }
