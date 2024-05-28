import 'package:circular_placeholder/circular_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/current_category_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/filtered_recipe_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRecipeLandscapeScreen extends ConsumerWidget {
  const CategoryRecipeLandscapeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(currentCategoryProvider);
    final categoryItems =
        List<Widget>.from(Recipe.categories.map((category) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  ref.read(currentCategoryProvider.notifier).state =
                      category.values.first;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                          height: 70,
                          width: 70,
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
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            )));
    return Row(children: [
      SizedBox(
          width: 120,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Container(
            color: const Color.fromARGB(60, 51, 167, 51),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: categoryItems,
                ),
              ),
            ),
          ))),
      const FilteredRecipesList(),
    ]);
  }
}
