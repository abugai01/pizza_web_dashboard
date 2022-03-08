import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double verticalPadding;

  CustomDivider({this.verticalPadding = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Divider());
  }
}
