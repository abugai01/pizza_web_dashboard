import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/models/helpers/data_elem.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/overview_cards.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/available_drivers_table.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/revenue_section_large.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/pages/overview/widgets/revenue_section_small.dart';
import 'package:pizza_web_dashboard/layout.dart';

//TODO: сделать график с количеством заказов
//TODO: этот раздел должен отвечать на вопрос "а че собсно сейчас происходит?"
class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    //TODO: проблема в info card!
                    child: OverviewCards(
                      [
                        DataElem("Заказы в процессе", 5),
                        DataElem("Завершено сегодня", 5),
                        DataElem("Отменено сегодня", 5),
                        DataElem("Запланировано сегодня", 5),
                      ],
                      vertical: false,
                    ),
                  ),
                  // if (!ResponsiveWidget.isSmallScreen(context))
                  //   RevenueSectionLarge()
                  // else
                  //   RevenueSectionSmall(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
