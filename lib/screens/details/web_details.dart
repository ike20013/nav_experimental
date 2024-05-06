import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebDetails extends StatelessWidget {
  final int id;
  final bool isChatOpened;
  final String? messageId;

  const WebDetails({
    super.key,
    required this.id,
    required this.isChatOpened,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Curr id is $id'),
                ElevatedButton(
                  onPressed: () => context.go('/home/details/500?chat'),
                  child: Text('Open chat'),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/home/details/500'),
                  child: Text('Close chat'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.go('/home/details/500?chat&messageId=123123123'),
                  child: Text('Open Message'),
                )
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: -1,
                child: child,
              ),
              child: isChatOpened
                  ? Container(
                      width: 500,
                      color: Colors.red,
                      child: Text(messageId ?? 'No messages selected'),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
