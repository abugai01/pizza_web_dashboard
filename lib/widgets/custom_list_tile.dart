import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/config/style.dart';

class CustomListTile extends StatelessWidget {
  final String? text;
  final IconData iconData;
  final double height;
  final double iconSize;
  final Widget? trailing;

  CustomListTile(this.text,
      {this.iconData = Icons.info_outlined,
      this.height = 36,
      this.iconSize = 24,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return (text == null || text == '')
        ? Container()
        : SizedBox(
            height: height,
            child: ListTile(
              leading: Icon(iconData, size: iconSize, color: Colors.grey[500]),
              trailing: trailing == null ? SizedBox() : trailing,
              //dense: true,
              title: Text(text!, style: cardDetailsStyle),
              enabled: false,
              minLeadingWidth: 10,
            ));
  }
}
