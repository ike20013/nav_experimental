import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/office/documents_details_page.dart';
import 'package:navigation_experimental/screens/office/office_page.dart';

class OfficeLocation extends BeamLocation<BeamState> {
  OfficeLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<String> get pathPatterns => ['/office/:tab/:id'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('office'),
        title: 'Office',
        child: OfficePage(),
      ),
      if (state.pathParameters.containsKey('id'))
        BeamPage(
          key: ValueKey('document-${state.pathParameters['id']}'),
          title: 'Document',
          child: DocumentsDetailsPage(id: state.pathParameters['id']!),
        ),
    ];
  }
}
