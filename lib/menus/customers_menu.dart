import 'dart:io';

import 'package:restaurant_reservation/menus/reservations_menu_customer.dart';
import 'package:restaurant_reservation/menus/restaurant_menu_for_customers.dart';
import 'package:restaurant_reservation/menus/restaurant_menu_for_staff.dart';
import 'package:restaurant_reservation/menus/staffs_menu.dart';
import '../services/navigator_service.dart';
import 'menu.dart';

class CustomersMenu extends Menu{
  static const id = "/users_menu";

  @override
  build() async {
    print("Welcome to system!\n"
        "1 - Menu\n"
        "2 - Reserve a table\n"
        "0 - Go Back");
    String? menuSelection = stdin.readLineSync();

    switch(menuSelection){
      case "1":{
        await Navigator.push(RestaurantMenuCustomers());
      }
      case "2":{
        await Navigator.push(ReservationsMenuCustomer());
      }
      case "0":{
        await Navigator.pop();
      }
    }
  }
}