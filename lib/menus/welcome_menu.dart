import 'dart:io';

import '../services/navigator_service.dart';
import 'meal_menu.dart';
import 'menu.dart';

class WelcomeMenu extends Menu{
  static const id = "/welcome_menu";

  @override
  build() async {
    print("How do you want to enter the system\n"
        "1 - as a user"
        "2 - as a staff");
    String? menuSelection = stdin.readLineSync();

    switch(menuSelection){
      case "1":{
        await Navigator.push(UserListMenu());
      }
    }
  }

}