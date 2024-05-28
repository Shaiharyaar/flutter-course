import 'package:flutter/material.dart';

class FavoriteRecipeItem extends StatelessWidget {
  final String recipeName;

  const FavoriteRecipeItem({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Placeholder(
          child: SizedBox(
            height: 120,
            width: 82,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          recipeName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
