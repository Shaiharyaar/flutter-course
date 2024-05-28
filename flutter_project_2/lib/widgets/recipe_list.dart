import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/widgets/recipe_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipeProvider);
    List<Widget> recipeListItems = List<Widget>.from(
        recipes.reversed.take(10).map((recipe) => RecipeItem(recipe: recipe)));
    return Column(children: recipeListItems);
  }
}
