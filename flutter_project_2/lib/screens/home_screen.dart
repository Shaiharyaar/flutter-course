import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_2/providers/current_category_provider.dart';
import 'package:flutter_project_2/providers/current_index_nav_provider.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/category_item.dart';
import 'package:flutter_project_2/widgets/favorite_recipe_item.dart';
import 'package:flutter_project_2/widgets/recipe_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeList = ref.watch(recipeProvider);
    print({recipeList});
    final user = ref.watch(userProvider);
    final categoryItems =
        List<Widget>.from(Recipe.categories.map((category) => Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 10,
              ),
              child: InkWell(
                onTap: () {
                  ref.read(currentCategoryProvider.notifier).state =
                      category.values.first;
                  context.push(RoutesPath.categoryRecipe);
                },
                child: CategoryItem(
                  categoryName: category.values.first,
                ),
              ),
            )));
    final favoriteItems = recipeList
        .where((recipe) => recipe.favorite.contains(user?.uid))
        .map((recipe) => Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 10,
              ),
              child: InkWell(
                onTap: () {
                  context.push(RoutesPath.recipe, extra: recipe);
                },
                child: FavoriteRecipeItem(
                  recipeName: recipe.title,
                ),
              ),
            ))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                          fontSize: 16),
                    ),
                    Consumer(builder: (builder, ref, _) {
                      return TextButton(
                          onPressed: () {
                            ref
                                .read(currentIndexNavProvider.notifier)
                                .update((state) => state = 1);
                          },
                          child: const Text(
                            "Show all",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ));
                    })
                  ],
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: categoryItems),
            ),
            user == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Favorites',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                              fontSize: 16),
                        ),
                        TextButton(
                            onPressed: favoriteItems.isEmpty
                                ? null
                                : () {
                                    context.go(RoutesPath.favRecipes);
                                  },
                            child:
                                Text(favoriteItems.isEmpty ? "" : "Show All"))
                      ],
                    )),
            user == null
                ? const SizedBox()
                : favoriteItems.isEmpty
                    ? const SizedBox(
                        height: 170,
                        child: Center(child: Text("No favorites found")))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: favoriteItems),
                      ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recipes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                        fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(RoutesPath.recipes);
                    },
                    child: const Text(
                      "Show all",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const RecipeList(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                showCloseIcon: true,
                closeIconColor: Colors.black,
                content: Text('You need to be logged in to add recipe!',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.orange,
              ),
            );
          } else {
            context.push(RoutesPath.addRecipe);
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
