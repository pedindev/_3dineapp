import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/rating.dart';

class SupabaseRatingService {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  // Salvar uma avaliação
  Future<void> saveRating(Rating rating) async {
    await _supabase.from('ratings').insert({
      'model_id': rating.modelId,
      'user_name': rating.userName,
      'score': rating.score,
      // created_at será preenchido automaticamente pelo Supabase
    });
  }
  
  // Obter avaliações para um modelo específico
  Future<List<Rating>> getRatingsForModel(String modelId) async {
    final data = await _supabase
        .from('ratings')
        .select()
        .eq('model_id', modelId)
        .order('created_at', ascending: false);
    
    return (data as List<dynamic>).map((item) => Rating(
      id: item['id'].toString(),
      modelId: item['model_id'],
      userName: item['user_name'],
      score: item['score'],
      date: DateTime.parse(item['created_at']),
    )).toList();
  }
  
  // Calcular média de avaliações para um modelo
  Future<double> getAverageRating(String modelId) async {
    final response = await _supabase
        .rpc('get_average_rating', params: {'model_id_param': modelId});
    
    if (response == null) {
      return 0.0;
    }
    
    return response.toDouble();
  }
}