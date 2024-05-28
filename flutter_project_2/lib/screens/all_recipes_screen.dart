import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_project_2/providers/recipe_provider.dart';
import 'package:flutter_project_2/widgets/recipe_item.dart';
import 'package:flutter_project_2/widgets/screen_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllRecipesScreen extends ConsumerStatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AllRecipesScreenState createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends ConsumerState<AllRecipesScreen> {
  static const _pageSize = 20;
  final PagingController<int, RecipeModel> _pagingController =
      PagingController(firstPageKey: 0);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchPage(int pageKey) async {
    try {
      Query query =
          _firestore.collection('recipes').orderBy('title').limit(_pageSize);
      print({"query": query});
      // Use the last document as the starting point for the next query
      if (pageKey != 0) {
        DocumentSnapshot lastDocument = await _firestore
            .collection('recipes')
            .orderBy('title')
            .limit(pageKey)
            .get()
            .then((snapshot) => snapshot.docs.last);
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();
      final newItems = querySnapshot.docs.map((doc) {
        print({doc: doc.data()});
        return RecipeModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      print({newItems});

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      print({'error': error});
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
    ref.listen<List<RecipeModel>>(recipeProvider, (previous, next) {
      _pagingController.refresh();
    });
    return ScreenWrapper(
      title: "All Recipes",
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
