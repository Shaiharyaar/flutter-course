// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/utils/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecipeScreen extends ConsumerWidget {
  final RecipeModel recipe;
  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final recipes = ref.watch(recipeProvider);
    final selectedRecipe = recipes.firstWhere((r) => r.id == recipe.id);
    final isFavSelected = selectedRecipe.favorite.contains(user?.uid);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: Colors.black,
                child: Hero(
                  tag: recipe.id!,
                  child: Placeholder(
                      color: Colors.green,
                      fallbackHeight: MediaQuery.of(context).size.height * 0.55,
                      fallbackWidth: MediaQuery.of(context).size.width,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width,
                      )),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Text(
                    "recipe.title recipe.title recipe.title recipe.title recipe.title recipe.title recipe.title recipe.title ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              Positioned(
                  top: MediaQuery.of(context).viewPadding.top + 5,
                  left: 15,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ))),
              Positioned(
                top: MediaQuery.of(context).viewPadding.top + 5,
                right: 15,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 10, 138, 4)),
                    elevation: MaterialStateProperty.all(2),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 1, horizontal: 10)),
                  ),
                  onPressed: () {
                    // toggle favorite
                    if (user == null) {
                      Helper.showSnackbar(context, Status.warning,
                          'You need to be login to add favorites');

                      return;
                    }
                    ref.read(recipeProvider.notifier).toggleFavorite(recipe);
                    if (recipe.favorite.contains(user.uid)) {
                      Helper.showSnackbar(context, Status.info,
                          'Recipe removed from favorites');
                    } else {
                      Helper.showSnackbar(
                          context, Status.info, 'Recipe added to favorites');
                    }
                  },
                  label: Text(
                      "Favorites: ${selectedRecipe.favorite.length.toString()}"),
                  icon: Icon(
                    Icons.star,
                    color: isFavSelected ? Colors.yellow : Colors.grey,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 21)),
                Text(recipe.description,
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 20),
                Text("Category",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 21)),
                SizedBox(height: 6),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), // Shadow color
                            spreadRadius: 4, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 3), // Offset from the top
                          )
                        ]),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                        child: Text(
                            Recipe.categories
                                .firstWhere(
                                  (element) =>
                                      element.values.first == recipe.category,
                                  orElse: () =>
                                      {"not-found": "no category found"},
                                )
                                .values
                                .first,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)))),
                const SizedBox(height: 20),
                Text("Ingredients",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 21)),
                Text(recipe.ingredients,
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(33, 76, 175, 79),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 40, left: 15, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Description",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 21)),
                          Text(recipe.description,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                        ])),
              ))
        ],
      )),
    );
  }
}
