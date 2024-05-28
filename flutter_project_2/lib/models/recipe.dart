import 'dart:convert';

String recipeToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  String? id;
  String title;
  String description;
  String steps;
  String userId;
  String category;
  String ingredients;
  List<dynamic> favorite;

  RecipeModel({
    this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.userId,
    required this.category,
    required this.ingredients,
    required this.favorite,
  });

  factory RecipeModel.fromFirestore(Map<String, dynamic> data, String id) {
    return RecipeModel(
      id: id,
      title: data["title"],
      description: data["description"],
      steps: data["steps"],
      userId: data["userId"],
      category: data["category"],
      ingredients: data["ingredients"],
      favorite: data["favorite"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "steps": steps,
        "userId": userId,
        "category": category,
        "ingredients": ingredients,
        "favorite": favorite,
      };
}
