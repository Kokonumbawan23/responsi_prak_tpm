class Meal {
  List<MealElement> meals;

  Meal({
    required this.meals,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        meals: List<MealElement>.from(
            json["meals"].map((x) => MealElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class MealElement {
  String strMeal;
  String strMealThumb;
  String idMeal;

  MealElement({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory MealElement.fromJson(Map<String, dynamic> json) => MealElement(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
