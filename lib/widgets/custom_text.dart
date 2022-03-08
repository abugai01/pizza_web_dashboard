import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextStyle? style;
  final TextAlign? align;

  CustomText(
      {required this.text,
      this.size,
      this.color,
      this.weight,
      this.style,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ??
          TextStyle(
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal),
      textAlign: align ?? TextAlign.start,
    );
  }
}
