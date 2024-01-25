import 'dart:io';

import 'package:restaurant_reservation/services/navigator_service.dart';

import 'menu.dart';

class RestaurantMenuCustomers extends Menu{
  static const id = "/restaurant_menu";

  @override
  build() async {
    for(int i = 0; i< Menu.foodList.length; i++){
      print("$i - ${Menu.foodList[i].foodName} - \$${Menu.foodList[i].foodPrice}");
    }
    print("Type anything to go back: ");
    String? menuSelection = stdin.readLineSync();

    switch(menuSelection){
      default:{
        await Navigator.pop();
      }
    }
  }
}