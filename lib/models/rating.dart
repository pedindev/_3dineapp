class Rating {
  final String modelId;
  final String userName;
  final int score; // 1 a 5
  final DateTime date;

  Rating({
    required this.modelId,
    required this.userName,
    required this.score,
    required this.date,
  });

  // Converter para JSON (para salvar no SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'modelId': modelId,
      'userName': userName,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  // Criar objeto a partir de JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      modelId: json['modelId'],
      userName: json['userName'],
      score: json['score'],
      date: DateTime.parse(json['date']),
    );
  }
}