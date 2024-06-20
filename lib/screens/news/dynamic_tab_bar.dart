import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/widgets/sliver_tab_bar.dart';

mixin DynamicTabsPageMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  late final TabController _tabController;
  late final Map<String, ScrollController> _scrollControllers;

  /// [Uri] path
  Uri get uri;

  /// [Key] for uri path
  String get queryParamKey;

  /// [Tabs] list
  List<String> get tabs;

  String? get currentTab => uri.queryParameters[queryParamKey];

  void updateRoutePath(String category);

  @override
  void initState() {
    super.initState();

    _scrollControllers = {};
    final int initCategoryIndex = tabs.indexWhere((category) => category == currentTab);

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initCategoryIndex != -1 ? initCategoryIndex : 0,
    )..addListener(() {
        if (!_tabController.indexIsChanging) {
          final int index = tabs.indexWhere((c) => c == currentTab);

          /// Если возвращаемся назад на страницу [без query]
          if (index == -1 && _tabController.index == 0) return;

          /// Обновляем [query] параметр в [path] при смене индекса таб контроллера
          if (index != _tabController.index) {
            updateRoutePath(tabs[_tabController.index]);
          }
        }
      });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_tabController.indexIsChanging) {
      final int index = tabs.indexWhere((c) => c == currentTab);
      // Если есть появились различия в path и индексе таб контроллера, обновляем контроллер
      if (index != _tabController.index) {
        _tabController.animateTo(index != -1 ? index : 0);
      }
    }
  }

  void setupScrollControllers(String category) {
    if (_scrollControllers[category] == null) {
      _scrollControllers[category] = ScrollController();
    }
  }
}

class DynamicTabBar extends StatefulWidget {
  final List<String> categories;
  final Uri uri;

  const DynamicTabBar({
    super.key,
    required this.categories,
    required this.uri,
  });

  @override
  State<DynamicTabBar> createState() => _DynamicTabBarState();
}

class _DynamicTabBarState extends State<DynamicTabBar>
    with SingleTickerProviderStateMixin, DynamicTabsPageMixin<DynamicTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverTabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            tabs: widget.categories.map((c) => Tab(text: c)).toList(),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: widget.categories
            .map(
              (category) => Builder(builder: (context) {
                setupScrollControllers(category);

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
                              onTap: () => context.goNamed('newsDetail',
                                  pathParameters: {'id': '$index'},
                                  queryParameters: {'category': category}),
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

  @override
  Uri get uri => widget.uri;

  @override
  List<String> get tabs => widget.categories;

  @override
  String get queryParamKey => 'category';

  @override
  void updateRoutePath(String category) {
    context.go('/news?category=$category');
  }
}
