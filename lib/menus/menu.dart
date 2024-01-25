import '../models/reservation.dart';
import '../models/category.dart';
import '../models/food.dart';

abstract class Menu {
  static List<Category> catList = [Category(name: "category1")];
  static List<Food> foodList = [
    Food(foodName: "Food 1", foodPrice: 10.0, category: Category(name: "category1"))
  ];
  static List<Reservation> reservationsList = [Reservation(foodList: foodList, dayOfWeek: 1, tableNumber: 1, numberOfPpl: 4)];

  bool doesCatExist(String newCatName) {
    return catList.any((cat) => cat.name == newCatName);
  }

  Category findByName(String catName) {
    return catList.firstWhere((cat) => cat.name == catName);
  }

  static int totalTables = 20;

  static int isTableAvailable(int dayOfWeek) {
    int occupiedTables = 0;

    for (var reservation in reservationsList) {
      if (reservation.dayOfWeek == dayOfWeek) {
        occupiedTables++;
      }
    }

    return occupiedTables;
  }
  build();
}