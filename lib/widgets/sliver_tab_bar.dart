import 'package:flutter/material.dart';
import 'package:navigation_experimental/widgets/tab_bar.dart';

class SliverTabBar extends BaseTabBar {
  final EdgeInsetsGeometry padding;

  const SliverTabBar({
    super.key,
    required super.tabs,
    super.onChange,
    super.controller,
    super.isScrollable,
    super.tabAlignment,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        pinned: true,
        centerTitle: false,
        titleSpacing: 0,
        toolbarHeight: 42,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BaseTabBar(
            tabs: tabs,
            controller: controller,
            onChange: onChange,
            isScrollable: isScrollable,
            tabAlignment: tabAlignment,
          ),
        ),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
