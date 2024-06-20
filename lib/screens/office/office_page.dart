import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/screens/office/documents_page.dart';
import 'package:navigation_experimental/screens/office/tasks_page.dart';
import 'package:navigation_experimental/widgets/sliver_tab_bar.dart';

mixin StaticTabsPageMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  late final TabController _tabController;

  TabController get tabController => _tabController;

  int get currentIndex;

  void goBranch(int index, {bool initialLocation});

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentIndex,
    )..addListener(() {
        if (!_tabController.indexIsChanging) {
          if (_tabController.index != currentIndex) {
            goBranch(
              _tabController.index,
              initialLocation: _tabController.index == currentIndex,
            );
          }
        }
      });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_tabController.indexIsChanging) {
      if (currentIndex != _tabController.index) {
        _tabController.animateTo(currentIndex);
      }
    }
  }
}

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

class _OfficePageState extends State<OfficePage>
    with SingleTickerProviderStateMixin, StaticTabsPageMixin<OfficePage> {
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

  @override
  int get currentIndex => widget.navigationShell.currentIndex;

  @override
  void goBranch(int index, {bool initialLocation = false}) {
    widget.navigationShell.goBranch(index, initialLocation: initialLocation);
  }
}
