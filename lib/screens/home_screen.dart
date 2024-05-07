import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
