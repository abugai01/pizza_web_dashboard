import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/models/helpers/data_elem.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/info_card.dart';

class OverviewCards extends StatelessWidget {
  final List<DataElem> data;
  final bool vertical;

  OverviewCards(this.data, {this.vertical = true});

  @override
  Widget build(BuildContext context) {
    //double _width = MediaQuery.of(context).size.width;

    return vertical == true
        ? Column(children: buildInfoCards(data))
        : Row(children: buildInfoCards(data));
  }

  List<Widget> buildInfoCards(List<DataElem> data) {
    List<Widget> res = [];

    for (int i = 0; i < data.length; i++) {
      res.add(
        Padding(
          padding: EdgeInsets.all(5),
          //TODO: цвет настроить
          child: InfoCard(
            title: data[i].key,
            value: data[i].value.toString(),
            onTap: () {},
          ),
        ),
      );
    }

    return res;
  }
}
