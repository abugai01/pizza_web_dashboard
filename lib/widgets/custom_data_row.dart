import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class CustomDataRow extends StatelessWidget {
  final String? field;
  final String? value;

  CustomDataRow(this.field, this.value);

  @override
  Widget build(BuildContext context) {
    if (field == null || value == null || value == '')
      return SizedBox();
    else
      return Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                            text: field!, size: 14, color: Colors.grey[700]))),
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 7,
                    child: Text(value!, style: TextStyle(fontSize: 16))),
              ]));
  }
}

class CustomDataRow1 extends StatelessWidget {
  final dynamic field;
  final dynamic value;

  final int leftColumnFlex;
  final int rightColumnFlex;
  final double spaceBetweenColumns;
  final double textSize;
  final double verticalPadding;
  final double horizontalPadding;

  CustomDataRow1({
    required this.field,
    required this.value,
    this.leftColumnFlex = 1,
    this.rightColumnFlex = 1,
    this.spaceBetweenColumns = 10,
    this.textSize = 14,
    this.verticalPadding = 5,
    this.horizontalPadding = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (field == null || field == '' || value == null || value == '')
      return SizedBox();
    else
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: leftColumnFlex,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                          CustomText(text: field.toString(), size: textSize))),
              SizedBox(width: spaceBetweenColumns),
              Expanded(
                  flex: rightColumnFlex,
                  child: Align(
                      alignment: Alignment.center,
                      child:
                          CustomText(text: value.toString(), size: textSize))),
            ]),
      );
  }
}
