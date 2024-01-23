import 'dart:io';

import 'package:restaurant_reservation/menus/menu.dart';
import '../models/category.dart';
import '../models/food.dart';

class AddMealMenu extends Menu{
  static const id = "/staffs_menu";

  @override
  build() async {
    print("Name: ");
    String? foodName = stdin.readLineSync();
    while(foodName == null || foodName.isEmpty){
      print("Food name cant be null! Try again.");
      foodName = stdin.readLineSync();
    }
    print("Price: ");
    double? foodPrice = double.tryParse(stdin.readLineSync()!);
    while(foodPrice == null){
      print("Food price cant be anything but double (ex: 1.0, 1.2)! Try again.");
      foodPrice = double.tryParse(stdin.readLineSync()!);
    }
    print("Categry: ");
    String? newCatName = stdin.readLineSync();
    Category? newCat;
    while(newCatName == null || foodName.isEmpty){
      print("Category cant be null! Try again.");
      newCatName = stdin.readLineSync();
    }
    if(doesCatExist(newCatName)){
      newCat = findByName(newCatName);
    } else{
      newCat = Category(name: newCatName);
      Menu.catList.add(newCat);
    }

    Menu.foodList.add(Food(foodName: foodName, foodPrice: foodPrice, category: newCat));

    print(Menu.foodList);

    print("Successfully added!");
    print("Name: ${Menu.foodList.last.foodName}\n"
        "Price: ${Menu.foodList.last.foodPrice}\n"
        "Category: ${Menu.foodList.last.category.name}");
  }
}