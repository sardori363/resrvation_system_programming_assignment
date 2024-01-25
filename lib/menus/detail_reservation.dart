import 'dart:io';

import 'package:restaurant_reservation/menus/menu.dart';
import 'package:restaurant_reservation/menus/reservations_menu_staff.dart';
import 'package:restaurant_reservation/menus/staffs_menu.dart';
import 'package:restaurant_reservation/models/category.dart';
import 'package:restaurant_reservation/models/reservation.dart';

import '../models/food.dart';
import '../services/navigator_service.dart';

class DetailReservation extends Menu{
  static const id = "/detail_reservation";
  late int resIndex;

  DetailReservation({required this.resIndex});

  @override
  build() async {
    var reserved = Menu.reservationsList[resIndex];
    double totalPrice = Menu.reservationsList[resIndex].foodList.map((food) => food.foodPrice).fold(0, (a, b) => a + b);
    print("$resIndex - Day: ${ReservationsMenuStaff.day[reserved.dayOfWeek+1]};\n"
        "Table: ${reserved.tableNumber};\n"
        "Number of hosts: ${reserved.numberOfPpl}\n"
        "Total: ${totalPrice}");

    print("Order:");
    for(int i = 0; i<reserved.foodList.length; i++){
      print("Food name: ${reserved.foodList[i].foodName}, Price: ${reserved.foodList[i].foodPrice}");
    }
    print("\n");


    print("1 - Edit current food\n"
        "2 - Delete current food\n");
    print("Type anything else to go back: ");
    int? menuSelection = int.parse(stdin.readLineSync()!);
    switch(menuSelection){
      case 1:{
        print("Enter new DAY or press ENTER to leave it the same: ");
        print("1 - Monday\n"
            "2 - Tuesday\n"
            "3 - Wednesday\n"
            "4 - Thursday\n"
            "5 - Friday\n"
            "6 - Saturday\n"
            "7 - Sunday\n");
        int? newDay = int.tryParse(stdin.readLineSync()!);
        if(newDay == null){
          newDay = Menu.reservationsList[resIndex].dayOfWeek;
        }
        while(newDay!<1 || newDay>7){
          stdout.writeln("Enter new day in numbers(1-7)");
          newDay = int.tryParse(stdin.readLineSync()!);
        }

        print("Enter new TABLE NUMBER or press ENTER to leave it the same: ");
        int? newTable = int.tryParse(stdin.readLineSync()!);
        if(newTable == null){
          newTable = Menu.reservationsList[resIndex].tableNumber;
        }
        int occpupiedtables = Menu.isTableAvailable(newDay);
        while(newTable!<occpupiedtables || newTable>20){
          if(occpupiedtables==20){
            print("All other tables are occupied!\n"
                "Total number of tables: ${Menu.totalTables}");
          }
          newTable = int.tryParse(stdin.readLineSync()!);
        }

        print("Enter new NUMBER OF HOSTS or press ENTER to leave it the same: ");
        int? newHosts = int.tryParse(stdin.readLineSync()!);
        if(newHosts == null){
          newHosts = Menu.reservationsList[resIndex].numberOfPpl;
        }
        while(newHosts!<1 || newHosts>4){
          stdout.writeln("Enter the number of ppl(1-4):");
          newHosts = int.tryParse(stdin.readLineSync()!);
        }

        print("Do you really want to UPDATE ORDER? Type 'yes' to update or ENTER to leave it the same:");
        List<Food> newOrder = [];
        String? confirmation = stdin.readLineSync();

        if (confirmation?.toLowerCase().trim() == "yes") {
          while (true) {
            print("Choose a meal by entering its number or enter 0 to finish ordering:");
            for (int i = 0; i < Menu.foodList.length; i++) {
              print("$i ${Menu.foodList[i].foodName} - \$${Menu.foodList[i].foodPrice}");
            }

            int? mealNumber = int.tryParse(stdin.readLineSync()!);

            if(mealNumber == null || mealNumber<0 || mealNumber>Menu.foodList.length){
              break;
            }

            print("Enter the quantity for this meal:");
            int? quantity = int.tryParse(stdin.readLineSync()!);

            if (quantity == null || quantity <= 0) {
              print("Invalid quantity. Please enter a valid number greater than 0.");
              continue;
            }

            // Add the selected meal and quantity to the basket
            for (int i = 0; i < quantity; i++) {
              newOrder.add(Menu.foodList[mealNumber]);
            }
          }
        }else{
          newOrder = Menu.reservationsList[resIndex].foodList;
        }

        // print("Enter new category or press enter to leave it the same: ");
        // String? newCatName = stdin.readLineSync();
        // Category? newCat;
        // if(newCatName == null){
        //   newCat = Menu.foodList[foodIndex].category;
        // } else{
        //   if(doesCatExist(newCatName)){
        //     newCat = findByName(newCatName);
        //   } else{
        //     newCat = Category(name: newCatName);
        //     Menu.catList.add(newCat);
        //   }
        // }

        Menu.reservationsList[resIndex] = Reservation(foodList: newOrder, dayOfWeek: newDay, tableNumber: newTable, numberOfPpl: newHosts);

        print("List of reservations for week:");
        for(int i = 0; i<Menu.reservationsList.length; i++){
          var reserved = Menu.reservationsList[i];
          double totalCurrentPrice = Menu.reservationsList[i].foodList.map((food) => food.foodPrice).fold(0, (a, b) => a + b);
          print("$i - Day: ${ReservationsMenuStaff.day[reserved.dayOfWeek+1]}; Table: ${reserved.tableNumber}; Number of hosts: ${reserved.numberOfPpl}; Total: ${totalCurrentPrice}");
        }

      }case 2:{
      print("Are you sure? Type 'yes' to remove:");
      String? userchoice = stdin.readLineSync();
      if(userchoice!.trim()=="yes"){
        Menu.reservationsList.removeAt(resIndex);
        print("Deleted!");
      } else{
        await Navigator.push(ReservationsMenuStaff());
      }
    }default:{
        Navigator.push(ReservationsMenuStaff());
      }
    }
  }
}