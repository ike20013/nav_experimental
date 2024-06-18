import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/library/library/library.dart';
import 'package:navigation_experimental/screens/library/library_details/library_details.dart';

class LibraryLocation extends BeamLocation<BeamState> {
  LibraryLocation(RouteInformation super.routeInformation);

  @override
  List<String> get pathPatterns => ['/library/library_details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
       
          const BeamPage(
            key: ValueKey('library'),
            title: 'Articles',
            child: LibraryPage(),
          ),
        if (state.uri.pathSegments.contains('library_details'))
          const BeamPage(
            key: ValueKey('library_details'),
            title: 'Library Details',
            child: LibraryDetails(),
          ),
      ];
}
