class Review {
  final String id;
  final String userId;
  final String userName;
  final String comment;
  final double rating;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      id: data['id'],
      userId: data['userId'],
      userName: data['userName'],
      comment: data['comment'],
      rating: data['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'comment': comment,
      'rating': rating,
    };
  }
}
