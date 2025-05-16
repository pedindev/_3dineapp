import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rating.dart';

class RatingService {
  static const String _ratingsKey = 'model_ratings';

  // Salvar uma avaliação
  static Future<void> saveRating(Rating rating) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Obter avaliações existentes
    List<Rating> ratings = await getRatings();
    
    // Adicionar nova avaliação
    ratings.add(rating);
    
    // Converter para JSON e salvar
    List<String> ratingsJson = ratings.map((r) => jsonEncode(r.toJson())).toList();
    await prefs.setStringList(_ratingsKey, ratingsJson);
  }

  // Obter todas as avaliações
  static Future<List<Rating>> getRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final ratingsJson = prefs.getStringList(_ratingsKey) ?? [];
    
    return ratingsJson
        .map((json) => Rating.fromJson(jsonDecode(json)))
        .toList();
  }

  // Obter avaliações para um modelo específico
  static Future<List<Rating>> getRatingsForModel(String modelId) async {
    List<Rating> allRatings = await getRatings();
    return allRatings.where((rating) => rating.modelId == modelId).toList();
  }

  // Calcular média de avaliações para um modelo
  static Future<double> getAverageRating(String modelId) async {
    List<Rating> modelRatings = await getRatingsForModel(modelId);
    
    if (modelRatings.isEmpty) {
      return 0.0;
    }
    
    int total = modelRatings.fold(0, (sum, rating) => sum + rating.score);
    return total / modelRatings.length;
  }
}