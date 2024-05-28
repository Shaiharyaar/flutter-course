import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/current_category_provider.dart';
import 'package:flutter_project_2/utils/helper.dart';
import 'package:flutter_project_2/widgets/recipe_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FilteredRecipesList extends ConsumerStatefulWidget {
  const FilteredRecipesList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilteredRecipesScreenState createState() => _FilteredRecipesScreenState();
}

class _FilteredRecipesScreenState extends ConsumerState<FilteredRecipesList> {
  static const _pageSize = 20;
  final PagingController<int, RecipeModel> _pagingController =
      PagingController(firstPageKey: 0);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchPage(int pageKey) async {
    final selectedCategory = ref.read(currentCategoryProvider);
    if (selectedCategory == null) {
      Helper.showSnackbar(
          context, Status.error, "Seems like category is not selected");
    }
    try {
      Query query = _firestore
          .collection('recipes')
          .where('category', isEqualTo: selectedCategory)
          .orderBy('title')
          .limit(_pageSize);
      // Use the last document as the starting point for the next query
      if (pageKey != 0) {
        DocumentSnapshot lastDocument = await _firestore
            .collection('recipes')
            .where('category', isEqualTo: selectedCategory)
            .orderBy('title')
            .limit(pageKey)
            .get()
            .then((snapshot) => snapshot.docs.last);
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();
      final newItems = querySnapshot.docs.map((doc) {
        return RecipeModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      print('error');
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(currentCategoryProvider, (previous, next) {
      _pagingController.refresh();
    });
    return SizedBox(
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width > 500 ? 120 : 0),
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          (MediaQuery.of(context).size.width > 500 ? 0 : 121),
      child: PagedListView<int, RecipeModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<RecipeModel>(
          itemBuilder: (context, item, index) => RecipeItem(
            recipe: item,
          ),
        ),
      ),
    );
  }
}
