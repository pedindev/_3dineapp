class Rating {
  final String id;
  final String modelId;
  final String userName;
  final int score; // 1 a 5
  final DateTime date;

  Rating({
    this.id = '',
    required this.modelId,
    required this.userName,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelId': modelId,
      'userName': userName,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id']?.toString() ?? '',
      modelId: json['modelId'] ?? json['model_id'] ?? '',
      userName: json['userName'] ?? json['user_name'] ?? '',
      score: json['score'] ?? 0,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : (json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now()),
    );
  }
}