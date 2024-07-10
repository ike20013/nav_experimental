import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsId;
  const NewsDetailPage({
    super.key,
    required this.newsId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(newsId),
            ElevatedButton(
              onPressed: () => context.pushNamed('documents_details', queryParameters: {'category': 'second'},),
              child: const Text('DetailsDoucments'),
            )
          ],
        ),
      ),
    );
  }
}
