import 'dart:io';

import 'package:restaurant_reservation/menus/customers_menu.dart';
import 'package:restaurant_reservation/services/navigator_service.dart';

import '../models/food.dart';
import '../models/reservation.dart';
import 'menu.dart';

class ReservationsMenuCustomer extends Menu {
  static const id = "/reservations_menu_customer";

  @override
  build() async {
    print("Welcome to our reservation system!\n"
        "Please enter the required information so we can find you a table");

    print("Choose the day: ");
    print("1 - Monday\n"
        "2 - Tuesday\n"
        "3 - Wednesday\n"
        "4 - Thursday\n"
        "5 - Friday\n"
        "6 - Saturday\n"
        "7 - Sunday\n");
    stdout.writeln("Choose the day in numbers(1-7):");
    int? chosenDay = int.tryParse(stdin.readLineSync()!);
    while (chosenDay == null || chosenDay < 1 || chosenDay > 7) {
      stdout.writeln("Choose the day in numbers(1-7):");
      chosenDay = int.tryParse(stdin.readLineSync()!);
    }

    stdout.writeln("Enter the number of ppl(1-4):");
    int? numOfPpl = int.tryParse(stdin.readLineSync()!);
    while (numOfPpl == null || numOfPpl < 1 || numOfPpl > 4) {
      stdout.writeln("Enter the number of ppl(1-4):");
      numOfPpl = int.tryParse(stdin.readLineSync()!);
    }

    // Check table availability
    if (Menu.isTableAvailable(chosenDay) < Menu.totalTables) {
      print("Congratulations, your table number is ${Menu.reservationsList.last.tableNumber + 1}");
    } else {
      print("Sorry, the table is not available for the selected day.");
      return;
    }

    List<Food> basket = [];

    // Set minimum and maximum values for the number of meals
    const int minMeals = 1;
    const int maxMeals = 10;

    while (true) {
      print("Choose a meal by entering its NUMBER or ENTER to finish ordering:");
      for (int i = 0; i < Menu.foodList.length; i++) {
        print("$i ${Menu.foodList[i].foodName} - \$${Menu.foodList[i].foodPrice}");
      }

      int? mealNumber = int.tryParse(stdin.readLineSync()!);

      if (mealNumber == null || mealNumber < 0 || mealNumber >= Menu.foodList.length) {
        break;
      }

      print("Enter the quantity for this meal:");
      int? quantity = int.tryParse(stdin.readLineSync()!);

      if (quantity == null || quantity < minMeals || quantity > maxMeals) {
        print("Invalid quantity. Please enter a number between $minMeals and $maxMeals.");
        continue;
      }

      // Create a new list for each reservation
      List<Food> reservationFoodList = [];

      // Add the selected meal and quantity to the reservationFoodList
      for (int i = 0; i < quantity; i++) {
        reservationFoodList.add(Menu.foodList[mealNumber]);
      }

      // Display the selected meals
      print("Your selected meals for this order:");
      for (int i = 0; i < reservationFoodList.length; i++) {
        print("${i + 1} ${reservationFoodList[i].foodName} - \$${reservationFoodList[i].foodPrice}");
      }

      // Calculate total price for this reservation
      double totalPrice = reservationFoodList.map((food) => food.foodPrice).fold(0, (a, b) => a + b);

      print("Total price for this order: \$${totalPrice}");

      // Confirm the order
      stdout.writeln("Do you want to add this to your basket? (yes/no)");
      String? confirmation = stdin.readLineSync();

      if (confirmation?.toLowerCase().trim() == "yes") {
        // Add the reservationFoodList to the basket
        basket.addAll(reservationFoodList);
      }

      // Ask if the customer wants to continue ordering
      stdout.writeln("Do you want to continue ordering? (yes/no)");
      String? continueOrdering = stdin.readLineSync();

      if (continueOrdering?.toLowerCase().trim() != "yes") {
        break;
      }
    }

    // Check if the number of meals is within the required range
    if (basket.length < minMeals || basket.length > maxMeals) {
      print("Invalid number of meals. You must order between $minMeals and $maxMeals meals.");
      await Navigator.push(CustomersMenu());
    }

    // Display basket contents
    print("Your order basket:");
    for (int i = 0; i < basket.length; i++) {
      print("${i + 1} ${basket[i].foodName} - \$${basket[i].foodPrice}");
    }

    // Calculate total price
    double totalPrice = basket.map((food) => food.foodPrice).fold(0, (a, b) => a + b);

    print("Total price: \$${totalPrice}");

    // Confirm the order
    stdout.writeln("Do you want to confirm the order? (yes/no)");
    String? confirmation = stdin.readLineSync();

    if (confirmation?.toLowerCase().trim() == "yes") {
      // Create Reservation object
      Reservation reservation = Reservation(
        foodList: List.from(basket), // Create a copy of the basket to avoid reference issues
        dayOfWeek: chosenDay,
        tableNumber: Menu.reservationsList.last.tableNumber + 1,
        numberOfPpl: numOfPpl,
      );

      // Add the reservation to the list
      Menu.reservationsList.add(reservation);

      print("Reservation confirmed! Thank you for choosing our restaurant.");
      basket.clear();
    } else {
      print("Order canceled. Thank you for visiting our reservation system.");
    }
  }
}
