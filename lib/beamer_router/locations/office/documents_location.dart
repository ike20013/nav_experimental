import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/office/documents_details_page.dart';
import 'package:navigation_experimental/screens/office/documents_screen.dart';

class DocumentsLocation extends BeamLocation<BeamState> {
  DocumentsLocation(RouteInformation super.routeInformation);

  @override
  List<String> get pathPatterns => ['/office/documents', '/office/documents/:id'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('documents'),
        title: 'Documents',
        child: DocumentsScreen(),
      ),
      if (state.uri.pathSegments.length > 2 && state.uri.pathSegments[2] == 'documents')
        BeamPage(
          key: ValueKey('document-${state.pathParameters['id']}'),
          title: 'Document',
          child: DocumentsDetailsPage(id: state.pathParameters['id']!),
        ),
    ];
  }
}