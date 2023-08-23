import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:flutter/material.dart';
 
class WidgetSearchMenu extends SearchDelegate {
  final List<String> names;
  
  WidgetSearchMenu(this.names);

  void _onGoToBook(BuildContext context, String name) async {
    var index = names.indexOf(name);
    Navigator.pushNamed(context, "/chapters", arguments: BOOK.values[index]);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var name in names) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(matchQuery[index]),
        onTap: () => _onGoToBook(context, matchQuery[index]),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var name in names) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(matchQuery[index]),
        onTap: () => _onGoToBook(context, matchQuery[index]),
      ),
    );
  }
}
