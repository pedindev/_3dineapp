import 'package:flutter/material.dart';
import '../models/model_3d.dart';
import '../data/models_data.dart';
import '../widgets/model_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final Color categoryColor;
  
  const CategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });
  
  @override
  Widget build(BuildContext context) {
    // Filtrar modelos pela categoria
    final List<Model3D> categoryModels = predefinedModels
        .where((model) => model.category == categoryId)
        .toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: categoryColor,
        foregroundColor: Colors.white,
      ),
      body: categoryModels.isEmpty
          ? const Center(
              child: Text(
                'Nenhum modelo encontrado nesta categoria',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryModels.length,
              itemBuilder: (context, index) {
                return ModelCard(model: categoryModels[index]);
              },
            ),
    );
  }
}