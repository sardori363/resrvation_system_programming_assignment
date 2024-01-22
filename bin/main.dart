import 'package:restaurant_reservation/menus/meal_menu.dart';
import 'package:restaurant_reservation/menus/welcome_menu.dart';
import 'package:restaurant_reservation/my_app.dart';

void main() async {

  MyApp(
      home: WelcomeMenu(),
      routes: {WelcomeMenu.id: WelcomeMenu(),
        UserListMenu.id: UserListMenu()});
}