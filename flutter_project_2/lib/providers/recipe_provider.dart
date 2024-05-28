import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_2/models/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeNotifier extends StateNotifier<List<RecipeModel>> {
  RecipeNotifier() : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();
    final recipes = snapshot.docs.map((doc) {
      return RecipeModel.fromFirestore(doc.data(), doc.id);
    }).toList();
    print({recipes});

    state = recipes;
  }

  Future<void> addRecipe(RecipeModel data) async {
    final recipeData = data.toJson();

    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final recipe = RecipeModel.fromFirestore(recipeData, recipeRef.id);
    state = [...state, recipe];
  }

  Future<void> updateRecipe(RecipeModel data) async {
    final recipeData = data.toJson();

    await _firestore.collection('recipes').doc(data.id).update(recipeData);
    final recipe = RecipeModel.fromFirestore(recipeData, data.id!);
    state = [..._replaceRecipeById(state, recipe)];
  }

  Future<void> toggleFavorite(RecipeModel data) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final List<String> updatedFavorites = List<String>.from(data.favorite);
    final bool isFavorite = updatedFavorites.contains(user.uid);

    if (isFavorite) {
      updatedFavorites.remove(user.uid);
    } else {
      updatedFavorites.add(user.uid);
    }

    await _firestore.collection('recipes').doc(data.id).update({
      'favorite': updatedFavorites,
    });

    final List<RecipeModel> updatedRecipes = [...state];
    for (int i = 0; i < updatedRecipes.length; i++) {
      if (updatedRecipes[i].id == data.id) {
        updatedRecipes[i].favorite = updatedFavorites;
        break;
      }
    }
    state = updatedRecipes;
  }

  Future<void> deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();
    state = [...removeRecipeById(state, id)];
  }

  List<RecipeModel> _replaceRecipeById(
      List<RecipeModel> recipes, RecipeModel newRecipe) {
    for (int i = 0; i < recipes.length; i++) {
      if (recipes[i].id == newRecipe.id) {
        recipes[i] = newRecipe;
        return recipes;
      }
    }
    return recipes;
  }

  List<RecipeModel> removeRecipeById(List<RecipeModel> recipes, String id) {
    List<RecipeModel> updatedRecipes = List.from(recipes);
    updatedRecipes.removeWhere((recipe) => recipe.id == id);
    return updatedRecipes;
  }

  // void deleteNote(String id) async {
  //   await _firestore.collection('notes').doc(id).delete();
  //   state = state.where((note) => note.id != id).toList();
  // }
}

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<RecipeModel>>(
    (ref) => RecipeNotifier());
