import '../models/category.dart';
import '../models/food.dart';

abstract class Menu {
  static List<Category> catList = [Category(name: "category1")];
  static List<Food> foodList = [
    Food(foodName: "Food 1", foodPrice: 10.0, category: Category(name: "category1"))
  ];

  build();

  bool doesCatExist(String newCatName) {
    return catList.any((cat) => cat.name == newCatName);
  }

  Category findByName(String catName) {
    return catList.firstWhere((cat) => cat.name == catName);
  }
}
