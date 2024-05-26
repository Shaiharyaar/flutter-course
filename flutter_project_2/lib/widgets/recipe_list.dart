import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/loading_provider.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<RecipeList> {
  showAlertDialog(BuildContext context, RecipeModel recipe) {
    Widget deleteButton = TextButton(
      child: const Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed: () async {
        context.pop();
        ref
            .read(loadingStateProvider.notifier)
            .startLoader("Deleting your recipe!");
        await ref.read(recipeProvider.notifier).deleteRecipe(recipe.id!);
        // for visual effects
        Future.delayed(const Duration(milliseconds: 3000), () {
          ref.read(loadingStateProvider.notifier).stopLoader();
        });
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

  _onDeleteClick(RecipeModel recipe) {
    showAlertDialog(context, recipe);
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipeProvider);
    final user = ref.watch(userProvider);
    List<Widget> recipeListItems =
        List<Widget>.from(recipes.reversed.take(10).map((recipe) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Stack(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      context.push(RoutesPath.recipe, extra: recipe);
                    },
                    child: Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Placeholder(
                                  child: SizedBox(
                                    height: 110,
                                    width: 90,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width * 0.9) -
                                        150,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ]),
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
                              _onDeleteClick(recipe);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                ],
              ),
            )));
    return Column(children: recipeListItems);
  }
}
