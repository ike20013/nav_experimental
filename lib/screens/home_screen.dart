import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text('123'),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => context.goNamed(detailsScreenRoute,
                      pathParameters: {'id': '500'}),
                  child: const Text('Open details'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(detailsScreenRoute,
                      pathParameters: {'id': '500'},
                      queryParameters: {'chat': ''}),
                  child: const Text('Open details with chat'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    detailsScreenRoute,
                    pathParameters: {'id': '500'},
                    queryParameters: {'chat': '', 'messageId': '999999999'},
                  ),
                  child: const Text('Open details with chat on message'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    'library',
                  ),
                  child: const Text('Go to library'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    'library_details',
                  ),
                  child: const Text('Go to library Details'),
                ),
                ElevatedButton(
                  onPressed: () => context.pushNamed(
                    'library',
                  ),
                  child: const Text('Push to library'),
                ),
                ElevatedButton(
                  onPressed: () => context.go(
                    '/office/documents',
                  ),
                  child: const Text('Go to Office Documents'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    'documents_details',
                  ),
                  child: const Text('Go to Office Documents Details'),
                ),
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    'tasks',
                  ),
                  child: const Text('Go to Office Tasks'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
