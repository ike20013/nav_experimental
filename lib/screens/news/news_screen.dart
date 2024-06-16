import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

class NewsPage extends StatefulWidget {
  final String? category;
  const NewsPage({super.key, this.category});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  final List<String> categories = ['first', 'second', 'third'];

  late final TabController _tabController;

  @override
  void initState() {
    final int initCategory =
        categories.indexWhere((element) => element == widget.category);

    _tabController = TabController(
        length: categories.length,
        vsync: this,
        initialIndex: initCategory != -1 ? initCategory : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) {
            // _tabController.animateTo(value);

            context.go('/news/${categories[value]}');
          },
          tabs: categories
              .map(
                (e) => Text(e),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories
            .map(
              (e) => Center(
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
