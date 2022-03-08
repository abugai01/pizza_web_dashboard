import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/navigation_controller.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/routing/routes.dart';

//TODO: сделать так, чтобы все влазило!!!
class UsersTable extends StatelessWidget {
  final List<User> data;

  UsersTable(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: [
              DataColumn2(
                label: Text("Профиль"),
                size: ColumnSize.S,
              ),
              DataColumn(
                label: Text("Имя"),
              ),
              DataColumn(
                label: Text('Телефон'),
              ),
              DataColumn(
                label: Text('Email'),
              ),
              // DataColumn(
              //   label: Text('Адрес'),
              // ),
              // DataColumn(
              //   label: Text('Рейтинг'),
              // ),
              //TODO: придумать что-то или убрать!
              DataColumn(
                label: Text('Action'),
              ),
            ],
            rows: List<DataRow>.generate(
                data.length,
                (index) => DataRow(cells: [
                      DataCell(IconButton(
                        icon: Icon(Icons.link),
                        color: userLinkColor,
                        onPressed: () {
                          NavigationController.navigateTo(context,
                              route: RouteGenerator.genLink(Routes.user,
                                  userId: data[index].id));
                        },
                      )),
                      DataCell(CustomText(text: data[index].fullName)),
                      DataCell(CustomText(text: data[index].phone)),
                      DataCell(CustomText(text: data[index].email)),
                      //TODO: с адресами порешать!
                      // DataCell(CustomText(
                      //     text: data[index]
                      //         .address
                      //         .addressText)), //TODO: подготовиться к множественным адресам
                      // DataCell(Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.deepOrange,
                      //       size: 18,
                      //     ),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     CustomText(
                      //       text: data[index].rating.toStringAsFixed(2),
                      //     )
                      //   ],
                      // )),
                      DataCell(Container(
                          decoration: BoxDecoration(
                            color: light,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: active, width: .5),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: CustomText(
                            text: "Block",
                            color: active.withOpacity(.7),
                            weight: FontWeight.bold,
                          ))),
                    ]))));
  }
}
