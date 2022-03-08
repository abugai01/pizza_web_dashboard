import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/models/constants/order_constants.dart';

const TextStyle cardTitleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    //color: Colors.grey,
    fontSize: 14);

const TextStyle cardStatusStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white);

TextStyle cardDetailsStyle = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey[800]);

Color? getOrderStatusColor(OrderStatus? status) {
  Color? _color;

  switch (status) {
    case OrderStatus.PENDING:
      _color = Colors.blueGrey[200];
      break;
    case OrderStatus.ACCEPTED:
      _color = Colors.orange[200];
      break;
    case OrderStatus.SEARCHING_FOR_EXECUTOR:
      _color = Colors.orange[400];
      break;
    case OrderStatus.EXECUTOR_FOUND:
      _color = Colors.green[200];
      break;
    case OrderStatus.AWAITING_EXECUTOR:
      _color = Colors.green[300];
      break;
    case OrderStatus.EXECUTING: //Cancelled
      _color = Colors.limeAccent[400];
      break;
    case OrderStatus.FINISHED: //Cancelled
      _color = Colors.green[900];
      break;
    case OrderStatus.CANCELLED: //Cancelled
      _color = Colors.red[200];
      break;
    case OrderStatus.EXPIRED: //Cancelled
      _color = Colors.red[200];
      break;
    case OrderStatus.ERROR: //Cancelled
      _color = Colors.red[200];
      break;
    default:
      _color = Colors.grey;
      break;
  }
  return _color;
}

Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
Color dark = Color(0xFF363740);
//Color active = Color(0xFF3C19C0);

const Color primary = Colors.black;
const red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const Color green = Colors.green;
const Color active = _themePurple; //Colors.orange;
const Color disabled = Colors.grey;

const Color _themePurple = Color.fromARGB(255, 136, 128, 255);
const Color themeOrange = Color.fromARGB(255, 255, 160, 106);
const Color themeDeepOrange = Color.fromARGB(255, 255, 138, 101);
const Color themePink = Color.fromARGB(255, 255, 181, 178);
const Color themeYellow = Color.fromARGB(255, 255, 217, 134);
const Color themeLightPink = Color.fromARGB(255, 255, 242, 236);

const themeLightGrey = Color.fromARGB(255, 243, 246, 253);

Map<int, Color> themePurpleSwatch = {
  50: Color.fromRGBO(136, 128, 255, 0.1),
  100: Color.fromRGBO(136, 128, 255, 0.2),
  200: Color.fromRGBO(136, 128, 255, 0.3),
  300: Color.fromRGBO(136, 128, 255, 0.4),
  400: Color.fromRGBO(136, 128, 255, 0.5),
  500: Color.fromRGBO(136, 128, 255, 0.6),
  600: Color.fromRGBO(136, 128, 255, 0.7),
  700: Color.fromRGBO(136, 128, 255, 0.8),
  800: Color.fromRGBO(136, 128, 255, 0.9),
  900: Color.fromRGBO(136, 128, 255, 1.0),
};

MaterialColor themePurple = MaterialColor(0XFF8880FF, themePurpleSwatch);

const Color orderLinkColor = Colors.lime;
const Color userLinkColor = Colors.deepPurple;
const Color executorLinkColor = Colors.blueAccent;
