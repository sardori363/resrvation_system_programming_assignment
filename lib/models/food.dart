import 'package:restaurant_reservation/models/category.dart';

class Food{
  late String foodName;
  late double foodPrice;
  late Category category;

  Food({required this.foodName, required this.foodPrice, required this.category});
}
