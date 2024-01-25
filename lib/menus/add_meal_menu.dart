import 'dart:io';

import 'package:restaurant_reservation/menus/menu.dart';
import 'package:restaurant_reservation/menus/staffs_menu.dart';
import 'package:restaurant_reservation/services/navigator_service.dart';
import '../models/category.dart';
import '../models/food.dart';

class AddMealMenu extends Menu {
  static const id = "/staffs_menu";

  @override
  build() async {
    // Set minimum and maximum values
    const double minFoodPrice = 1.0;
    const double maxFoodPrice = 100.0;
    const int maxMeals = 10;

    // Check if the maximum number of meals has been reached
    if (Menu.foodList.length >= maxMeals) {
      print("Cannot add more meals. Maximum limit reached.");
      return;
    }

    print("Name: ");
    String? foodName = stdin.readLineSync();
    while (foodName == null || foodName.isEmpty) {
      print("Food name can't be null! Try again.");
      foodName = stdin.readLineSync();
    }

    print("Price: ");
    double? foodPrice = double.tryParse(stdin.readLineSync()!);
    while (foodPrice == null || foodPrice < minFoodPrice || foodPrice > maxFoodPrice) {
      print("Food price should be a double between $minFoodPrice and $maxFoodPrice. Try again.");
      foodPrice = double.tryParse(stdin.readLineSync()!);
    }

    print("Category: ");
    String? newCatName = stdin.readLineSync();
    Category? newCat;
    while (newCatName == null || newCatName.isEmpty) {
      print("Category can't be null! Try again.");
      newCatName = stdin.readLineSync();
    }

    if (doesCatExist(newCatName)) {
      newCat = findByName(newCatName);
    } else {
      newCat = Category(name: newCatName);
      Menu.catList.add(newCat);
    }

    Menu.foodList.add(Food(foodName: foodName, foodPrice: foodPrice, category: newCat));

    print("Successfully added!");
    print("Name: ${Menu.foodList.last.foodName}\n"
        "Price: ${Menu.foodList.last.foodPrice}\n"
        "Category: ${Menu.foodList.last.category.name}");

    await Navigator.push(StaffsMenu());
  }
}
