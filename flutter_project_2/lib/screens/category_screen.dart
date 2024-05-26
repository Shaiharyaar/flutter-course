import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryItems = List<Widget>.from(Recipe.categories.map(
      (recipe) => TextButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
        child: CategoryItem(
          categoryName: recipe.values.first,
        ),
      ),
    ));
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.68,
      padding: const EdgeInsets.symmetric(vertical: 40),
      shrinkWrap: true,
      children: categoryItems,
    );
  }
}
