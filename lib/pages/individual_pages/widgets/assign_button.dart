import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/pages/orders/widgets/orders_table.dart';
import 'package:pizza_web_dashboard/widgets/table_button.dart';

//TODO: мб прикрутить сюда наследование от TableButton
class AssignButton extends StatelessWidget {
  final String text;
  final Function function;
  final bool isEnabled;
  final TableButtonDesign design;

  AssignButton(this.text,
      {required this.function,
      this.isEnabled = true,
      this.design = TableButtonDesign.classic});

  @override
  Widget build(BuildContext context) {
    TableButtonDesign _design = isEnabled ? design : TableButtonDesign.disabled;

    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: () {
              if (_design == TableButtonDesign.red)
                return Colors.red[50];
              else if (_design == TableButtonDesign.disabled)
                return Colors.grey[100];
              else
                return light;
            }(),
            borderRadius: BorderRadius.circular(20),
            //border: Border.all(color: active, width: .5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            text,
            style: TextStyle(
                color: () {
                  if (_design == TableButtonDesign.red)
                    return Colors.red;
                  else if (_design == TableButtonDesign.disabled)
                    return Colors.grey;
                  else
                    return active.withOpacity(.7);
                }(),
                fontSize: 12,
                decoration: isEnabled ? null : TextDecoration.lineThrough),
          ),
        ),
        onTap: () => isEnabled ? function() : null);
  }
}
