import 'package:flutter/material.dart';

class SearchArticle extends StatelessWidget {
  const SearchArticle({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SearchBar(
        controller: controller,
        padding: WidgetStatePropertyAll(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        leading: Icon(Icons.search),
        hintText: "Search Articles",
        elevation: WidgetStatePropertyAll(3),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).cardTheme.color,
        ),
      ),
    );
  }
}
