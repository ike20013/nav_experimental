import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(context.currentBeamLocation.state.routeInformation.uri.toString()),),
      body: Center(
          child: Column(
        children: [
          const Text('Library'),
          ElevatedButton(
            onPressed: () => context.beamToNamed('/library/library_details'),
            child: Text('Go to details'),
          ),
        ],
      )),
    );
  }
}
