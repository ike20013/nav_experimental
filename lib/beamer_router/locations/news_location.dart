import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/news/news_screen.dart';

class NewsLocation extends BeamLocation<BeamState> {
  NewsLocation(RouteInformation super.routeInformation);

  @override
  List<String> get pathPatterns => ['/news'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('news'),
          title: 'News',
          type: BeamPageType.noTransition,
          child: NewsPage(),
        ),
      ];
}