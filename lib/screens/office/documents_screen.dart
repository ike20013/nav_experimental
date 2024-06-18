import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Document $index'),
              onTap: () => 
                context.beamToNamed('/office/documents/$index'),
              
            );
          },
        ),
      ),
    );
  }
}
