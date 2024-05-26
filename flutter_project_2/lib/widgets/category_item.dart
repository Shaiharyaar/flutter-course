import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;

  const CategoryItem({super.key, required this.categoryName});

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
          categoryName,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
