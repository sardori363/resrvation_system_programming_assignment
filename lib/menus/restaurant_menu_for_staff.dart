import 'dart:io';

import 'package:restaurant_reservation/menus/detail_menu.dart';

import '../models/food.dart';
import '../services/navigator_service.dart';
import 'menu.dart';

class RestaurantMenuStaff extends Menu{
  static const id = "/restaurant_menu";

  @override
  build() async {
    print("Choose: ");
    // print(Menu.foodList);
    for(int i = 0; i < Menu.foodList.length; i++){
      print("$i - ${Menu.foodList[i].foodName} - \$${Menu.foodList[i].foodPrice}");
    }
    print("Type anything else to go back: ");
    int? menuSelection = int.tryParse(stdin.readLineSync()!);
    if(menuSelection == null){
      await Navigator.pop();
    }
    else if(0 <= menuSelection && menuSelection <= Menu.foodList.length) {
      await Navigator.push(DetailMenu(foodIndex: menuSelection));
    }
  }
}