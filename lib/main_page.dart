import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/beamer_router/locations/library_location.dart';
import 'package:navigation_experimental/beamer_router/locations/news_location.dart';
import 'package:navigation_experimental/beamer_router/locations/office/office_location.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;

  final routerDelegates = [
    // BeamerDelegate(
    //   initialPath: '/home',
    //   locationBuilder: (routeInformation, _) {
    //     if (routeInformation.uri.pathSegments.contains('home')) {
    //       return LibraryLocation(routeInformation);
    //     }
    //     return NotFound(path: routeInformation.uri.toString());
    //   },
    // ),
    BeamerDelegate(
      initialPath: '/library',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.uri.pathSegments.contains('library')) {
          return LibraryLocation(routeInformation);
        }
        return NotFound(path: routeInformation.uri.toString());
      },
    ),
    BeamerDelegate(
      initialPath: '/office',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.uri.pathSegments.contains('office')) {
          return OfficeLocation(routeInformation);
        }
        return NotFound(path: routeInformation.uri.toString());
      },
    ),
    BeamerDelegate(
      initialPath: '/news',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.uri.pathSegments.contains('news')) {
          return NewsLocation(routeInformation);
        }
        return NotFound(path: routeInformation.uri.toString());
      },
    ),
  ];

  final pathIndexMap = {
    'news': 2,
    'office': 1,
    'library': 0,
    // 'home': 0,
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.uri.pathSegments;
    currentIndex = pathIndexMap.entries
        .firstWhere((entry) => uriString.contains(entry.key), orElse: () => const MapEntry('home', 0))
        .value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          Beamer(
            routerDelegate: routerDelegates[0],
          ),
          Beamer(
            routerDelegate: routerDelegates[1],
          ),
          Beamer(
            routerDelegate: routerDelegates[2],
          ),
          // Beamer(
          //   routerDelegate: routerDelegates[3],
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        fixedColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Office'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.local_post_office), label: 'Office'),
          // BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            setState(() => currentIndex = index);
            routerDelegates[currentIndex].update(rebuild: false);
          } else {
            routerDelegates[currentIndex].beamBack();

            routerDelegates[currentIndex]
                .beamTo(routerDelegates[currentIndex].currentBeamLocation);
          }
        },
      ),
    );
  }

  // void _onTap(BuildContext context, int index) {
  //   // When navigating to a new branch, it's recommended to use the goBranch
  //   // method, as doing so makes sure the last navigation state of the
  //   // Navigator for the branch is restored.
  //   widget.navigationShell.goBranch(
  //     index,
  //     // A common pattern when using bottom navigation bars is to support
  //     // navigating to the initial location when tapping the item that is
  //     // already active. This example demonstrates how to support this behavior,
  //     // using the initialLocation parameter of goBranch.
  //     initialLocation: index == widget.navigationShell.currentIndex,
  //   );
  // }
}
