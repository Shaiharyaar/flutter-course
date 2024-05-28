class RoutesPath {
  static const String home = "/";
  static const String login = "/login";
  static const String recipe = "/recipe";
  static const String recipes = "/recipes";
  static const String favRecipes = "/favorite-recipes";
  static const String addRecipe = "/add-recipe";
  static const String categoryRecipe = "/category-recipe";

  static String editRecipe(String id) => "/edit-recipe/$id";
}

class Recipe {
  static List<Map<String, String>> categories = [
    {"breakfast": "Breakfast"},
    {"lunch": "Lunch"},
    {"dinner": "Dinner"},
    {"appetizer": "Appetizer"},
    {"salad": "Salad"},
    {"main_course": "Main-course"},
    {"side_dish": "Side-dish"},
    {"baked_goods": "Baked-goods"},
    {"dessert": "Dessert"},
    {"snack": "Snack"},
    {"soup": "Soup"},
    {"holiday": "Holiday"},
    {"vegetarian_dishes": "Vegetarian Dishes"},
    {"miscellaneous": "Miscellaneous"},
  ];
}
