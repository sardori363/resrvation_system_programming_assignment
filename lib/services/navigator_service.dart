import 'package:restaurant_reservation/menus/welcome_menu.dart';

import '../menus/menu.dart';

class Navigator{
  static final List<Menu> _menus = [WelcomeMenu()];

  static Future _runMenu() async{
    await _menus.last.build();
  }

  static Future push(Menu menu) async{
    _menus.add(menu);
    await _runMenu();
  }

  static Future pop() async{
    _menus.removeLast();
    await _runMenu();
  }
}