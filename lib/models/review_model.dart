class ReviewModel {
  final String senderName;
  final String description;
  final int rating;

  ReviewModel({
    required this.senderName,
    required this.description,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderName': senderName,
      'description': description,
      'rating': rating,
    };
  }

  factory ReviewModel.fromMap({required Map<String, dynamic> map}) {
    return ReviewModel(
      senderName: map['senderName'] as String,
      description: map['description'] as String,
      rating: map['rating'] as int,
    );
  }
}
