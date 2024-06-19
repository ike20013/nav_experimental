import 'package:flutter/material.dart';

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
        child: Text(newsId),
      ),
    );
  }
}
