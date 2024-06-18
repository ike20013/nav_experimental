import 'package:flutter/material.dart';

class DocumentsDetailsPage extends StatelessWidget {
  final String id;
  const DocumentsDetailsPage({super.key, required this.id,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Documents Details'),
      ),
    );
  }
}
