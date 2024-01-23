import 'dart:io';

import 'package:restaurant_reservation/menus/add_meal_menu.dart';
import 'package:restaurant_reservation/menus/menu.dart';
import 'package:restaurant_reservation/menus/reservations_menu.dart';
import 'package:restaurant_reservation/menus/restaurant_menu_for_staff.dart';
import '../services/navigator_service.dart';

class StaffsMenu extends Menu{
  static const id = "/staffs_menu";

  @override
  build() async {
    print("Welcome to system!\n"
        "1 - Menu\n"
        "2 - See reservations\n"
        "3 - Add meal to menu\n"
        "0 - Go Back");
    String? menuSelection = stdin.readLineSync();

    switch(menuSelection){
      case "1":{
        await Navigator.push(RestaurantMenuStaff());
      }
      case "2":{
        await Navigator.push(ReservationsMenu());
      }
      case "3":{
        await Navigator.push(AddMealMenu());
      }
      case "0":{
        await Navigator.pop();
      }
    }
  }
}