import 'package:flutter/material.dart';
import 'package:flutter_project_2/screens/category_recipe_landscape_screen.dart';
import 'package:flutter_project_2/screens/category_recipe_portrait_screen.dart';
import 'package:go_router/go_router.dart';

class CategoryRecipeScreenState extends StatelessWidget {
  const CategoryRecipeScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.of(context).size.width > 500
              ? const CategoryRecipeLandscapeScreen()
              : const CategoryRecipePortraitScreen(),
          Positioned(
              bottom: 16,
              left: MediaQuery.of(context).size.width > 500 ? null : 15,
              right: MediaQuery.of(context).size.width > 500 ? 15 : null,
              child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
