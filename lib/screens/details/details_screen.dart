import 'package:flutter/material.dart';
import 'package:navigation_experimental/screens/details/mobile_details.dart';
import 'package:navigation_experimental/screens/details/web_details.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  final bool isChatOpened;
  final String? messageId;

  const DetailsScreen({
    super.key,
    required this.id,
    this.isChatOpened = false,
    this.messageId,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MediaQuery.of(context).size.width >= 900
          ? WebDetails(
              id: widget.id,
              isChatOpened: widget.isChatOpened,
              messageId: widget.messageId,
            )
          : MobileDetails(
              id: widget.id,
              isChatOpened: widget.isChatOpened,
              messageId: widget.messageId,
              globalKey: scaffoldKey,
            ),
    );
  }
}
