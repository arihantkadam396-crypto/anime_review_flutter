class Review {
  final String user;
  final String text;
  final int rating; // 1..5
  final DateTime createdAt;

  Review({
    required this.user,
    required this.text,
    required this.rating,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'user': user,
        'text': text,
        'rating': rating,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json['user'] as String,
        text: json['text'] as String,
        rating: json['rating'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
