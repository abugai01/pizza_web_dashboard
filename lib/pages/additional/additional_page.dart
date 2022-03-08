import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/download/cubit_collection_download.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/responsiveness.dart';
import 'package:pizza_web_dashboard/layout.dart';
import 'package:pizza_web_dashboard/pages/additional/widgets/collection_button.dart';
import 'package:pizza_web_dashboard/routing/controllers.dart';
import 'package:pizza_web_dashboard/services/database.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

class AdditionalPage extends StatelessWidget {
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
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Выгрузить коллекцию в CSV"),
                      ),
                      Expanded(
                        child: BlocProvider<CubitCollectionDownload>(
                          create: (_) => CubitCollectionDownload(
                              context.read<FirestoreDatabase>()),
                          child: BlocBuilder<CubitCollectionDownload,
                              DownloadState>(
                            builder: (context, state) {
                              return Container(
                                child: ListView(
                                  children: <Widget>[
                                    CollectionButton('Заказы',
                                        icon:
                                            Icons.format_list_numbered_outlined,
                                        function: () {
                                      context
                                          .read<CubitCollectionDownload>()
                                          .downloadCollection(
                                              Collection.orders);
                                    }),
                                    CollectionButton('Пользователи',
                                        icon: Icons.people_alt_outlined,
                                        function: () {
                                      context
                                          .read<CubitCollectionDownload>()
                                          .downloadCollection(Collection.users);
                                    }),
                                    CollectionButton('Исполнители',
                                        icon: Icons.directions_walk_outlined,
                                        function: () {
                                      context
                                          .read<CubitCollectionDownload>()
                                          .downloadCollection(
                                              Collection.executors);
                                    }),
                                    CollectionButton('Telegram',
                                        icon: Icons.send_outlined,
                                        function: () {
                                      context
                                          .read<CubitCollectionDownload>()
                                          .downloadCollection(
                                              Collection.telegramMessages);
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text("Пока не придумал что сюда влепить"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
