import 'package:circular_placeholder/circular_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_2/providers/current_category_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/filtered_recipe_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRecipePortraitScreen extends ConsumerWidget {
  const CategoryRecipePortraitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(currentCategoryProvider);
    final categoryItems =
        List<Widget>.from(Recipe.categories.map((category) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  ref.read(currentCategoryProvider.notifier).state =
                      category.values.first;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircularPlaceholder(
                            color: Colors.green,
                          )),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: selectedCategory == category.values.first
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 33, 157, 37),
                                  ))
                              : const SizedBox())
                    ]),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 60,
                      child: Text(
                        category.values.first,
                        style: const TextStyle(
                          fontSize: 9,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            )));
    return SafeArea(
        child: Column(children: [
      SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: const Color.fromARGB(60, 51, 167, 51),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: categoryItems,
                    ),
                  ),
                ),
              ))),
      const FilteredRecipesList(),
    ]));
  }
}
