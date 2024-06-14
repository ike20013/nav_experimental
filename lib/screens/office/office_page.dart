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

class _OfficePageState extends State<OfficePage> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.officeNavigationShell.currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OfficePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final navigationShell = widget.officeNavigationShell;
    final page = _controller.page ?? _controller.initialPage;
    final index = page.round();
    if (index == navigationShell.currentIndex) {
      return;
    }
    _controller.animateToPage(
      widget.officeNavigationShell.currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationShell = widget.officeNavigationShell;
    final children = widget.children;

    return DefaultTabController(
      length: children.length,
      initialIndex: navigationShell.currentIndex,
      child: Builder(builder: (context) {


        return Scaffold(
          appBar: AppBar(
            title: const Text('Office'),
          ),
          body: Column(children: [
            TabBar(
              controller: DefaultTabController.of(context),
              tabs: const [
                Icon(Icons.abc),
                Icon(Icons.ac_unit),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: children.length,
                onPageChanged: (index) {
                  debugPrint('index: $index, currentIndex: ${navigationShell.currentIndex}');

                  // Ignore tap events.
                  if (index == navigationShell.currentIndex) {
                    return;
                  }

                  navigationShell.goBranch(
                    index,
                    initialLocation: false,
                  );
                },
                itemBuilder: (context, index) => children[index],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
