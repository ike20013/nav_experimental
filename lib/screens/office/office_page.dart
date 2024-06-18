import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/beamer_router/locations/office/documents_location.dart';
import 'package:navigation_experimental/beamer_router/locations/office/tasks_location.dart';
import 'package:navigation_experimental/screens/office/documents_screen.dart';
import 'package:navigation_experimental/screens/office/tasks_screen.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({
    super.key,
  });

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final routerDelegates = [
    BeamerDelegate(
      initialPath: '/office/documents',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.uri.pathSegments.contains('documents')) {
          return DocumentsLocation(routeInformation);
        }
        return NotFound(path: routeInformation.uri.toString());
      },
    ),
    BeamerDelegate(
      initialPath: '/office/tasks',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.uri.pathSegments.contains('tasks')) {
          return TasksLocation(routeInformation);
        }
        return NotFound(path: routeInformation.uri.toString());
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {

    //         routerDelegates[_tabController.index].update(rebuild: false);
    //       }

    // });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentBeam = context.currentBeamLocation.pathPatterns;
      if (currentBeam.contains('/tasks')) {
        _tabController.index = 1;
      } else {
        _tabController.index = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            context.currentBeamLocation.state.routeInformation.uri.toString()),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Documents'),
            Tab(text: 'Tasks'),
          ],
          onTap: (value) => routerDelegates[value].update(rebuild: true),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Beamer(
            routerDelegate: routerDelegates[0],
          ),
          Beamer(
            routerDelegate: routerDelegates[1],
          ),
        ],
      ),
    );
  }
}
