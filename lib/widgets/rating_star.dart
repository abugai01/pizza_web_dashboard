import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';


class RatingStar extends StatelessWidget {
  final String? ratingString;
  RatingStar(this.ratingString);

  @override
  Widget build(BuildContext context) {
    return ratingString == null ? Container() : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: Colors.deepOrange,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        CustomText(
          text: ratingString
        )
      ],
    );
  }
}
