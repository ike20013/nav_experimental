import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class LibraryDetails extends StatelessWidget {
  const LibraryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.currentBeamLocation.state.routeInformation.uri.toString()),),
        body: Center(child: const Text('Library Details')));
  }
}
