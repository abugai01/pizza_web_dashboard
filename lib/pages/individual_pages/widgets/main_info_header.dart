import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/constants/constants.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/header_buttons.dart';
import 'package:pizza_web_dashboard/routing/route_generator.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

//TODO: добавить статистику наверное
//TODO: кастомизировать кнопки!
//TODO: кастомизировать плейсхолдер аватарки

class MainInfoHeader extends StatelessWidget {
  final String? id; //Нужно, если есть кнопки, ведущие на страницы с id в адресе
  final String? mainInfo;
  final List<String?>? additionalInfo;
  final String? avatar;
  final List<Routes>? routes;

  const MainInfoHeader({
    this.id,
    this.mainInfo,
    this.additionalInfo,
    this.avatar,
    this.routes,
  });

  @override
  Widget build(BuildContext context) {
    String _additionalInfo =
        convertListToStringNullSafe(additionalInfo, separator: '  ·  ');

    return Container(
      height: 150,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildImage(avatar),
            SizedBox(width: 15),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildMainInfo(mainInfo),
                  _buildAdditionalInfo(_additionalInfo),
                ]),
            Expanded(child: Container()),
            HeaderButtons(id: id, routes: routes),
          ]),
    );
  }

  Widget _buildImage(String? avatar) {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        image: avatar == null
            ? DecorationImage(image: AssetImage(imgPathUser), fit: BoxFit.cover)
            : DecorationImage(
                //TODO: обработка ошибок при загрузке аватара
                image: NetworkImage(avatar),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.circular(70.0),
        border: Border.all(
          color: Colors.white,
          width: 8.0,
        ),
      ),
    );
  }

  Widget _buildMainInfo(String? name) {
    TextStyle _nameTextStyle = TextStyle(
      //fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return CustomText(
      text: name,
      style: _nameTextStyle,
    );
  }

  Widget _buildAdditionalInfo(String? contacts) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).scaffoldBackgroundColor,
      //   borderRadius: BorderRadius.circular(4.0),
      // ),
      child: CustomText(
        text: contacts,
        style: TextStyle(
          //fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

// Widget _buildButtons() {
//   EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10);
//
//   return Row(
//     children: <Widget>[
//       Padding(
//         padding: padding,
//         child: FloatingActionButton(
//           onPressed: () {
//             if (function != null) return function!();
//           },
//           heroTag: 'pets',
//           child: Icon(Icons.pets),
//         ),
//       ),
//       Padding(
//         padding: padding,
//         child: FloatingActionButton(
//           onPressed: () {
//             throw (UnimplementedError);
//           },
//           heroTag: 'addresses',
//           child: Icon(Icons.place),
//         ),
//       ),
//     ],
//   );
// }
}
