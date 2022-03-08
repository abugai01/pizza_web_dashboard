import 'package:flutter/material.dart';

class CollectionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? function;

  const CollectionButton(this.text, {this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: FloatingActionButton.extended(
        heroTag: text,
        onPressed: () {
          if (function != null) function!();
        },
        label: Text(text),
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}
