import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/config/style.dart';
import 'package:pizza_web_dashboard/routing/menu_items.dart';

class MenuController {
  static MenuController instance =
      MenuController(); //TODO: переделать нормально!

  String activeItem = overviewPageDisplayName;
  String hoverItem = "";

  changeActiveItemTo(String itemName) {
    activeItem = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem = itemName;
  }

  isHovering(String itemName) => hoverItem == itemName;

  isActive(String itemName) => activeItem == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case usersPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case ordersPageDisplayName:
        return _customIcon(Icons.format_list_numbered_outlined, itemName);
      case statsPageDisplayName:
        return _customIcon(Icons.insights_outlined, itemName);
      case paymentsPageDisplayName:
        return _customIcon(Icons.attach_money, itemName);
      case additionalPageDisplayName:
        return _customIcon(Icons.star_outline_outlined, itemName);
      case authPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);

      default:
        return _customIcon(Icons.help_outline_outlined, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}

// class MenuController extends GetxController {
//   static MenuController instance = Get.find();
//   var activeItem = overviewPageDisplayName.obs;
//
//   var hoverItem = "".obs;
//
//   changeActiveItemTo(String itemName) {
//     activeItem.value = itemName;
//   }
//
//   onHover(String itemName) {
//     if (!isActive(itemName)) hoverItem.value = itemName;
//   }
//
//   isHovering(String itemName) => hoverItem.value == itemName;
//
//   isActive(String itemName) => activeItem.value == itemName;
//
//   Widget returnIconFor(String itemName) {
//     switch (itemName) {
//       case overviewPageDisplayName:
//         return _customIcon(Icons.trending_up, itemName);
//       case clientsPageDisplayName:
//         return _customIcon(Icons.people_alt_outlined, itemName);
//       case petsPageDisplayName:
//         return _customIcon(Icons.pets_outlined, itemName);
//       case walkersPageDisplayName:
//         return _customIcon(Icons.directions_walk_outlined, itemName);
//       case ordersPageDisplayName:
//         return _customIcon(Icons.format_list_numbered_outlined, itemName);
//       case pricesPageDisplayName:
//         return _customIcon(Icons.paid_outlined, itemName);
//       case telegramPageDisplayName:
//         return _customIcon(Icons.send_outlined, itemName);
//       case mapPageDisplayName:
//         return _customIcon(Icons.public_outlined, itemName);
//       case authenticationPageDisplayName:
//         return _customIcon(Icons.exit_to_app, itemName);
//
//       default:
//         return _customIcon(Icons.help_outline_outlined, itemName);
//     }
//   }
//
//   Widget _customIcon(IconData icon, String itemName) {
//     if (isActive(itemName)) return Icon(icon, size: 22, color: dark);
//
//     return Icon(
//       icon,
//       color: isHovering(itemName) ? dark : lightGrey,
//     );
//   }
// }
