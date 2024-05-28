import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/widgets/recipe_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final searchTerms = ref.read(recipeProvider);
      List<RecipeModel> matchQuery = [];
      final searchText = query.toLowerCase();
      for (var element in searchTerms) {
        if (element.title.toLowerCase().contains(searchText) ||
            element.description.toLowerCase().contains(searchText) ||
            element.category.toLowerCase().contains(searchText) ||
            element.ingredients.toLowerCase().contains(searchText) ||
            element.steps.toLowerCase().contains(searchText)) {
          matchQuery.add(element);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          final res = matchQuery[index];
          return RecipeItem(recipe: res);
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final searchTerms = ref.read(recipeProvider);
      List<RecipeModel> suggestionQuery = [];
      suggestionQuery = searchTerms.take(4).toList();
      return ListView.builder(
        itemCount: suggestionQuery.length,
        itemBuilder: (context, index) {
          final res = suggestionQuery[index];
          return RecipeItem(recipe: res);
        },
      );
    });
  }
}
