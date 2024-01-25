import 'dart:io';

import 'package:restaurant_reservation/menus/menu.dart';
import 'package:restaurant_reservation/menus/staffs_menu.dart';
import 'package:restaurant_reservation/models/category.dart';

import '../models/food.dart';
import '../services/navigator_service.dart';

class DetailMenu extends Menu{
  static const id = "/detail_menu";
  late int foodIndex;

  DetailMenu({required this.foodIndex});

  @override
  build() async {
    print("Name: ${Menu.foodList[foodIndex].foodName}\n"
        "Price: ${Menu.foodList[foodIndex].foodPrice}\n"
        "Category: ${Menu.foodList[foodIndex].category.name}\n");

    print("1 - Edit current food\n"
        "2 - Delete current food\n");
    print("Type anything else to go back: ");
    int? menuSelection = int.parse(stdin.readLineSync()!);
    switch(menuSelection){
      case 1:{
        print("Enter new food name or press enter to leave it the same: ");
        String? newFoodName = stdin.readLineSync();
        if(newFoodName == null){
          newFoodName = Menu.foodList[foodIndex].foodName;
        }
        print("Enter new price or press enter to leave it the same: ");
        double? newPrice = double.tryParse(stdin.readLineSync()!);
        if(newPrice == null){
          newPrice = Menu.foodList[foodIndex].foodPrice;
        }
        print("Enter new category or press enter to leave it the same: ");
        String? newCatName = stdin.readLineSync();
        Category? newCat;
        if(newCatName == null){
          newCat = Menu.foodList[foodIndex].category;
        } else{
          if(doesCatExist(newCatName)){
            newCat = findByName(newCatName);
          } else{
            newCat = Category(name: newCatName);
            Menu.catList.add(newCat);
          }
        }

        Menu.foodList.removeAt(foodIndex);
        Menu.foodList.add(Food(foodName: newFoodName, foodPrice: newPrice, category: newCat));

        print(Menu.foodList);

        print("Successfully updated!");
        print("Name: ${Menu.foodList.last.foodName}\n"
            "Price: ${Menu.foodList.last.foodPrice}\n"
            "Category: ${Menu.foodList.last.category.name}");

      }case 2:{
        print("Are you sure? Type 'yes' to remove:");
        String? userchoice = stdin.readLineSync();
        if(userchoice!.trim()=="yes"){
          Menu.foodList.removeAt(foodIndex);
          print("Deleted!");
        } else{
          await Navigator.push(StaffsMenu());
        }
    }
    }
  }
}