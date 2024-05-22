import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Apple', 'Mango'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var element in searchTerms) {
      if (element.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final res = matchQuery[index];
        return ListTile(title: Text(res));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var element in searchTerms) {
      if (element.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final res = matchQuery[index];
        return ListTile(title: Text(res));
      },
    );
  }
}
