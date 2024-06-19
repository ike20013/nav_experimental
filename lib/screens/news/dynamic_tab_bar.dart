import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/widgets/sliver_tab_bar.dart';

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

class _DynamicTabBarState extends State<DynamicTabBar> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final Map<String, ScrollController> _scrollControllers;

  @override
  void initState() {
    super.initState();

    _scrollControllers = {};
    final int initCategory =
        widget.categories.indexWhere((category) => category == widget.currentCategory);

    if (initCategory == -1) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        _goRouterUpdateCategory(widget.categories[initCategory != -1 ? initCategory : 0]);
      });
    }

      _tabController = TabController(
        length: widget.categories.length,
        vsync: this,
        initialIndex: initCategory != -1 ? initCategory : 0,
      )..addListener(() {
          if (!_tabController.indexIsChanging) {
            log('${_tabController.index}');

            final uriCategory =
                GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

            final int index = widget.categories.indexWhere((c) => c == uriCategory);

            if (index != _tabController.index) {
              _goRouterUpdateCategory(widget.categories[_tabController.index]);
            }
          }
      });
  }

  @override
  void didUpdateWidget(covariant DynamicTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_tabController.indexIsChanging) {
      final uriCategory =
          GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['category'];

      final int index = widget.categories.indexWhere((c) => c == uriCategory);

      if (index != -1 && index != _tabController.index) {
        log('update');
        _tabController.animateTo(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 30,
          title:
              SafeArea(child: Text('${GoRouter.of(context).routeInformationProvider.value.uri}')),
        ),
        SliverTabBar(
          controller: _tabController,
          tabs: widget.categories.map((c) => Tab(text: c)).toList(),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: widget.categories
            .map(
              (category) => Builder(builder: (context) {
                _setupScrollController(category);

                return CustomScrollView(
                    key: PageStorageKey(category),
                    controller: _scrollControllers[category],
                    slivers: [
                      SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () => context.goNamed(
                                    'newsDetail',
                                    pathParameters: {'id': '$index'},
                                  ),
                              child: Text('Item $index')),
                          itemCount: 100,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                        ),
                      ),
                    ]);
              }),
            )
            .toList(),
      ),
    ));
  }

  void _goRouterUpdateCategory(String category) {
    context.go('/news?category=$category');
  }

  void _setupScrollController(String category) {
    if (_scrollControllers[category] == null) {
      _scrollControllers[category] = ScrollController();
    }
  }
}
// 