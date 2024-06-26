// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/utils/helper.dart';
import 'package:flutter_project_2/widgets/screen_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddRecipeScreen extends ConsumerStatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends ConsumerState<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  bool hasUserSubmittedFirstTime = false;
  bool isLoading = false;
  final _recipeTitleController = TextEditingController();
  final _recipeDescController = TextEditingController();
  final _recipeIngredientsController = TextEditingController();
  final _recipeStepsController = TextEditingController();
  final _recipeCategoryController = TextEditingController();

  _addRecipe(BuildContext ctx) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final recipeBody = RecipeModel(
        title: _recipeTitleController.text,
        description: _recipeDescController.text,
        steps: _recipeStepsController.text,
        ingredients: _recipeIngredientsController.text,
        userId: currentUser!.uid,
        favorite: [],
        category: _recipeCategoryController.text);
    await ref.read(recipeProvider.notifier).addRecipe(recipeBody);
    Helper.showSnackbar(ctx, Status.success, "Recipe has been added!");
    ctx.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        title: 'Add Screen',
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: hasUserSubmittedFirstTime
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Placeholder(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 150,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                    maxLength: 50,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == '') {
                                        return 'Please enter recipe title';
                                      }
                                      return null;
                                    },
                                    controller: _recipeTitleController,
                                    decoration: InputDecoration(
                                      label: Text("Recipe title"),
                                    ))),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                    controller: _recipeDescController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == '') {
                                        return 'Please enter recipe description';
                                      }
                                      return null;
                                    },
                                    maxLines: null,
                                    keyboardType:
                                        TextInputType.multiline, //or null
                                    decoration: InputDecoration(
                                      label: Text("Recipe Description"),
                                    ))),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: DropdownMenu(
                                controller: _recipeCategoryController,
                                label: Text('Category'),
                                menuHeight: 200,
                                width: MediaQuery.of(context).size.width - 30,
                                dropdownMenuEntries: Recipe.categories
                                    .map(
                                        (category) => DropdownMenuEntry<String>(
                                              value: category.values.first,
                                              label: category.values.first,
                                            ))
                                    .toList(),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                    controller: _recipeIngredientsController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == '') {
                                        return 'Please enter recipe ingredients';
                                      }
                                      return null;
                                    },
                                    maxLines: null,
                                    keyboardType:
                                        TextInputType.multiline, //or null
                                    decoration: InputDecoration(
                                      label: Text("Recipe Ingredients"),
                                    ))),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: TextFormField(
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 50),
                                    controller: _recipeStepsController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == '') {
                                        return 'Please enter steps to cook recipe';
                                      }
                                      return null;
                                    },
                                    minLines: 3,
                                    maxLines: null,
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.start,
                                    keyboardType:
                                        TextInputType.multiline, //or null
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(10, 76, 175, 79),
                                      label: Text(
                                        "Steps to Cook",
                                        textAlign: TextAlign.start,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                      ),
                                      // hintText: "Enter your text here"),
                                    ))),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 30,
                                  child: FilledButton.icon(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green)),
                                      onPressed: isLoading
                                          ? null
                                          : () async {
                                              setState(() {
                                                hasUserSubmittedFirstTime =
                                                    true;
                                                isLoading = true;
                                              });
                                              // Validate returns true if the form is valid, or false otherwise.
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (_recipeCategoryController
                                                        .text ==
                                                    '') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      showCloseIcon: true,
                                                      content: Text(
                                                          'Category is not selected. Select a category',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                } else {
                                                  await _addRecipe(context);
                                                }
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                      icon: isLoading
                                          ? Container(
                                              width: 24,
                                              height: 22,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3,
                                              ),
                                            )
                                          : Icon(Icons.add),
                                      label: Text("Add Recipe")
                                      // hintText: "Enter your text here"),
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ],
        ));
  }
}
