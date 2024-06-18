import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/office/tasks_screen.dart';

class TasksLocation extends BeamLocation<BeamState> {
  TasksLocation(RouteInformation super.routeInformation);

  @override
  List<String> get pathPatterns => ['/office/tasks'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('tasks'),
        title: 'Tasks',
        child: TasksScreen(),
      ),
    ];
  }
}