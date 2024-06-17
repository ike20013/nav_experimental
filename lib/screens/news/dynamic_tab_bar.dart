import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DynamicTabBar extends StatefulWidget {
  final List<String> categories;
  final String? currentCategory;
  const DynamicTabBar({
    super.key,
    required this.categories,
    required this.currentCategory,
  });

  @override
  State<DynamicTabBar> createState() => _DynamicTabBarState();
}

class _DynamicTabBarState extends State<DynamicTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    final int initCategory = widget.categories
        .indexWhere((element) => element == widget.currentCategory);

    if (initCategory == -1) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        context.go(
            '/news/${widget.categories[initCategory != -1 ? initCategory : 0]}');
      });
    }

    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
      initialIndex: initCategory != -1 ? initCategory : 0,
    );
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

            context.go('/news/${widget.categories[value]}');
          },
          tabs: widget.categories
              .map(
                (e) => Text(e),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.categories
            .map(
              (e) => Padding(
                key: ValueKey(e),
                padding: EdgeInsets.all(16),
                child: Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text(e),
                        ElevatedButton(
                          onPressed: () => context.go(
                              '/news/${widget.categories[_tabController.index]}/${_tabController.index + 100}'),
                          child: Text('Go To News'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) =>
                                Text('Item $index'),
                            itemCount: 100,
                          ),
                        ),
                      ],
                    )),
              ),
            )
            .toList(),
      ),
    );
  }
}
