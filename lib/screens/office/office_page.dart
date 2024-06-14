import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OfficePage extends StatelessWidget {
  final StatefulNavigationShell officeNavigationShell;
  final List<Widget> children;

  const OfficePage({
    super.key,
    required this.officeNavigationShell,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: children.length,
      initialIndex: officeNavigationShell.currentIndex,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (tabController.indexIsChanging) {
              officeNavigationShell.goBranch(
                tabController.index,
                initialLocation:
                    tabController.index == officeNavigationShell.currentIndex,
              );
            }
          });

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Icon(Icons.abc),
                  Icon(Icons.ac_unit),
                ],
              ),
            ),
            body: TabBarView(children: children),
          );
        },
      ),
    );
  }
}
