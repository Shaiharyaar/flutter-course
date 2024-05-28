import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/current_category_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/category_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryItems = List<Widget>.from(Recipe.categories.map(
      (category) => TextButton(
        onPressed: () {
          ref.read(currentCategoryProvider.notifier).state =
              category.values.first;
          context.push(RoutesPath.categoryRecipe);
        },
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
        child: CategoryItem(
          categoryName: category.values.first,
        ),
      ),
    ));
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 250
          ? 1
          : MediaQuery.of(context).size.width < 400
              ? 2
              : MediaQuery.of(context).size.width < 500
                  ? 3
                  : MediaQuery.of(context).size.width < 600
                      ? 4
                      : 5,
      childAspectRatio: 0.68,
      padding: const EdgeInsets.symmetric(vertical: 40),
      shrinkWrap: true,
      children: categoryItems,
    );
  }
}
