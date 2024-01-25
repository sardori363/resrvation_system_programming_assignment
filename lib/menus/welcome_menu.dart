import 'dart:io';

import 'package:restaurant_reservation/menus/customers_menu.dart';
import 'package:restaurant_reservation/menus/restaurant_menu_for_customers.dart';
import 'package:restaurant_reservation/menus/staffs_menu.dart';

import '../services/navigator_service.dart';
import 'restaurant_menu_for_staff.dart';
import 'menu.dart';

class WelcomeMenu extends Menu{
  static const id = "/welcome_menu";

  @override
  build() async {
    print("How do you want to enter the system\n"
        "1 - as a customer\n"
        "2 - as a staff");
    String? menuSelection = stdin.readLineSync();

    switch(menuSelection){
      case "1":{
        await Navigator.push(CustomersMenu());
      }
      case "2":{
        await Navigator.push(StaffsMenu());
      }
    }
  }

}