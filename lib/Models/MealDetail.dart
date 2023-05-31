class MealDetail {
  List<Map<String, String?>> meals;

  MealDetail({
    required this.meals,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) => MealDetail(
        meals: List<Map<String, String?>>.from(json["meals"].map((x) =>
            Map.from(x)
                .map((key, value) => MapEntry<String, String?>(key, value)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x)
            .map((key, value) => MapEntry<String, dynamic>(key, value)))),
      };
}
