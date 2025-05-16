import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  
  const CustomSearchBar({
    super.key,
    required this.onSearch,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Pesquisar modelos...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}