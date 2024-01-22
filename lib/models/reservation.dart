import 'package:restaurant_reservation/models/food.dart';
class Reservation{
  late List<Food> foodList;
  late DateTime dateTime;
  late int tableNumber;

  Reservation({required this.foodList, required this.dateTime, required this.tableNumber});
}