import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/loading_provider.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/utils/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecipeItem extends ConsumerWidget {
  final RecipeModel recipe;
  const RecipeItem({super.key, required this.recipe});

  showAlertDialog(BuildContext context, WidgetRef ref, RecipeModel recipe) {
    Widget deleteButton = TextButton(
      child: const Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed: () async {
        context.pop();
        ref
            .read(loadingStateProvider.notifier)
            .startLoader("Deleting your recipe!");
        await ref.read(recipeProvider.notifier).deleteRecipe(recipe.id!);
        // ignore: use_build_context_synchronously
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
      onPressed: () {
        context.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Recipe"),
      content: Text("Do you want to delete your recipe '${recipe.title}'?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _onDeleteClick(BuildContext context, WidgetRef ref, RecipeModel recipe) {
    showAlertDialog(context, ref, recipe);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              context.push(RoutesPath.recipe, extra: recipe);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Hero(
                              tag: recipe.id!,
                              child: const Placeholder(
                                child: SizedBox(
                                  height: 110,
                                  width: 90,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: IntrinsicWidth(
                            child: SizedBox(
                              height: 100,
                              // child: SizedBox(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Flexible(
                                      child: Text(
                                        recipe.description,
                                        maxLines: 4,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          user == null || user.uid != recipe.userId
              ? const SizedBox()
              : Positioned(
                  top: 0,
                  right: 40,
                  child: IconButton(
                    onPressed: () {
                      // print(RoutesPath.editRecipe(recipe.id!));
                      context.push(RoutesPath.editRecipe(recipe.id!));
                    },
                    iconSize: 21,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  )),
          user == null || user.uid != recipe.userId
              ? const SizedBox()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    iconSize: 21,
                    onPressed: () {
                      _onDeleteClick(context, ref, recipe);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ),
          Positioned(
              top: 5,
              left: 5,
              child: SizedBox(
                height: 30,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 10, 138, 4)),
                    elevation: MaterialStateProperty.all(2),
                    padding: MaterialStateProperty.all(EdgeInsets.all(2)),
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
                  label: Text(recipe.favorite.length.toString()),
                  icon: Icon(
                    Icons.star,
                    color: recipe.favorite.contains(user?.uid)
                        ? Colors.yellow
                        : Colors.grey,
                    size: 26,
                  ),
                ),
              )),
        ]));
  }
}
