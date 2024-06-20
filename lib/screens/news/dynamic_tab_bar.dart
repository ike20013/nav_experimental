import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_experimental/widgets/sliver_tab_bar.dart';

mixin DynamicTabsPageMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  late final TabController _tabController;
  late final Map<String, ScrollController> _scrollControllers;

  /// [Key] for uri path
  String get queryParamKey;

  /// Tabs names list
  List<String> get tabs;

  // Current tab
  String? get currentTab;

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
          /// Парсинг текущих query параметров
          final uriCategory = GoRouter.of(context)
              .routeInformationProvider
              .value
              .uri
              .queryParameters[queryParamKey];

          final int index = tabs.indexWhere((c) => c == uriCategory);

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
      /// Парсинг текущих query параметров
      final uriCategory =
          GoRouter.of(context).routeInformationProvider.value.uri.queryParameters[queryParamKey];

      final int index = tabs.indexWhere((c) => c == uriCategory);
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
    with SingleTickerProviderStateMixin, DynamicTabsPageMixin<DynamicTabBar> {
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
  List<String> get tabs => widget.categories;

  @override
  String? get currentTab => widget.currentCategory;

  @override
  String get queryParamKey => 'category';

  @override
  void updateRoutePath(String category) {
    context.go('/news?category=$category');
  }
}
