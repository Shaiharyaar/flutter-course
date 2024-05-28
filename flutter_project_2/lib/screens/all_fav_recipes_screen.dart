import 'package:flutter/material.dart';
import 'package:flutter_project_2/widgets/filtered_favorites_list.dart';
import 'package:flutter_project_2/widgets/screen_wrapper.dart';

class AllFavoriteRecipesScreen extends StatelessWidget {
  const AllFavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
        title: "Favorite Recipes", child: FilteredFavoriteRecipesList());
  }
}
