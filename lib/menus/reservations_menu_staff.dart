import 'dart:io';

import 'package:restaurant_reservation/menus/detail_reservation.dart';

import '../models/food.dart';
import '../models/reservation.dart';
import '../services/navigator_service.dart';
import 'menu.dart';

class ReservationsMenuStaff extends Menu {
  static const id = "/reservations_menu_staff";

  static List<String> day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  @override
  build() async {
    print("List of reservations for week:");
    for(int i = 0; i<Menu.reservationsList.length; i++){
      var reserved = Menu.reservationsList[i];
      reserved.foodList;
      double totalPrice = Menu.reservationsList[i].foodList.map((food) => food.foodPrice).fold(0, (a, b) => a + b);
      print("$i - Day: ${day[reserved.dayOfWeek-1]}; Table: ${reserved.tableNumber}; Number of hosts: ${reserved.numberOfPpl}; Total: ${totalPrice}");
    }
    print("Type anything else to go back: ");
    int? menuSelection = int.tryParse(stdin.readLineSync()!);
    if(menuSelection == null){
      await Navigator.pop();
    }
    else if(0 <= menuSelection && menuSelection <= Menu.reservationsList.length) {
      await Navigator.push(DetailReservation(resIndex: menuSelection));
    }
  }
}
