class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;
  final String thumbnail;
  final double price;
  final double rating;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.thumbnail,
    required this.price,
    required this.rating,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['description'] ?? '', // Mapping description to body
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'description': body,
      'thumbnail': thumbnail,
      'price': price,
      'rating': rating,
    };
  }
}
