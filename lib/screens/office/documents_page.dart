import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Documents'),
          ElevatedButton(
            onPressed: () => context.goNamed('documents_details'),
            child: const Text('Go To Details'),
          ),
        ],
      ),
    );
  }
}
