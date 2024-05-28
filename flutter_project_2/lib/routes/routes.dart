import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/screens/add_recipe_screen.dart';
import 'package:flutter_project_2/screens/all_fav_recipes_screen.dart';
import 'package:flutter_project_2/screens/all_recipes_screen.dart';
import 'package:flutter_project_2/screens/category_recipe_screen.dart';
import 'package:flutter_project_2/screens/edit_recipe_screen.dart';
import 'package:flutter_project_2/screens/login_screen.dart';
import 'package:flutter_project_2/screens/nav_screen.dart';
import 'package:flutter_project_2/screens/recipe_screen.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: RoutesPath.home, builder: (context, state) => const NavScreen()),
    GoRoute(
        path: RoutesPath.recipe,
        builder: (context, state) {
          return RecipeScreen(
            recipe: state.extra as RecipeModel,
          );
        }),
    GoRoute(
        path: RoutesPath.recipes,
        builder: (context, state) => AllRecipesScreen()),
    GoRoute(
        path: RoutesPath.favRecipes,
        builder: (context, state) => const AllFavoriteRecipesScreen()),
    GoRoute(
        path: RoutesPath.addRecipe,
        builder: (context, state) => const AddRecipeScreen()),
    GoRoute(
        path: RoutesPath.categoryRecipe,
        builder: (context, state) => const CategoryRecipeScreenState()),
    GoRoute(
        path: RoutesPath.editRecipe(':id'),
        builder: (context, state) =>
            EditRecipeScreen(recipeId: state.pathParameters['id']!)),
    GoRoute(
        path: RoutesPath.login,
        builder: (context, state) => const LoginScreen()),
  ],
);
