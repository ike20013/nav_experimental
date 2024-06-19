import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemBuilder: (context, index) => GestureDetector(
                // onTap: () => context.goNamed('newsDetail', pathParameters: {'id': '$index'}),
                child: Text('Document $index')),
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ],
    );
  }
}
