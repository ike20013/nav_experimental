import 'package:flutter/material.dart';

class BaseTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final Function(int)? onChange;
  final bool isScrollable;
  final TabAlignment? tabAlignment;

  const BaseTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onChange,
    this.isScrollable = false,
    this.tabAlignment,
  });

  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: SizedBox(
        height: 36,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: TabBar(
              splashFactory: InkRipple.splashFactory,
              // overlayColor: WidgetStatePropertyAll(context.shades.tp8),
              isScrollable: isScrollable,
              controller: controller,
              onTap: onChange,
              splashBorderRadius: BorderRadius.circular(50),
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.purple[300],
              ),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: tabs,
              tabAlignment: tabAlignment,
            ),
          ),
        ),
      ),
    );
  }
}
