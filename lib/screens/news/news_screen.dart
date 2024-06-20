import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/news/dynamic_tab_bar.dart';

class NewsPage extends StatelessWidget {
  final Uri uri;
  const NewsPage({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DynamicTabBar(
            categories: snapshot.data!,
            uri: uri,
          );
        }
        return const Center(
          child: SizedBox.square(
            dimension: 32,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      'first',
      'second',
      'third',
      'fourth',
      'fifth',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
    ];
  }
}
