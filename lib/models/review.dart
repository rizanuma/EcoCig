class Review {
  final String id;
  final String productId;
  final String userName;
  final String userEmail;
  final double rating;
  final String title;
  final String comment;
  final DateTime createdAt;
  final bool isVerifiedPurchase;
  final List<String> images;
  final int helpfulCount;

  Review({
    required this.id,
    required this.productId,
    required this.userName,
    required this.userEmail,
    required this.rating,
    required this.title,
    required this.comment,
    required this.createdAt,
    this.isVerifiedPurchase = false,
    this.images = const [],
    this.helpfulCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userName': userName,
      'userEmail': userEmail,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'isVerifiedPurchase': isVerifiedPurchase,
      'images': images,
      'helpfulCount': helpfulCount,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['productId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      rating: json['rating'].toDouble(),
      title: json['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      isVerifiedPurchase: json['isVerifiedPurchase'] ?? false,
      images: List<String>.from(json['images'] ?? []),
      helpfulCount: json['helpfulCount'] ?? 0,
    );
  }

  Review copyWith({
    String? id,
    String? productId,
    String? userName,
    String? userEmail,
    double? rating,
    String? title,
    String? comment,
    DateTime? createdAt,
    bool? isVerifiedPurchase,
    List<String>? images,
    int? helpfulCount,
  }) {
    return Review(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      images: images ?? this.images,
      helpfulCount: helpfulCount ?? this.helpfulCount,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Review && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Review(id: $id, productId: $productId, rating: $rating, title: $title)';
  }
}

// Sample reviews data
class ReviewData {
  static List<Review> getSampleReviews() {
    return [
      Review(
        id: '1',
        productId: '1',
        userName: 'Sarah M.',
        userEmail: 'sarah@example.com',
        rating: 5.0,
        title: 'Amazing sustainable shoes!',
        comment: 'I love these shoes! They\'re comfortable, stylish, and I feel good knowing they\'re made from recycled materials. The fit is perfect and they\'re great for my daily runs.',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        isVerifiedPurchase: true,
        helpfulCount: 12,
      ),
      Review(
        id: '2',
        productId: '1',
        userName: 'Mike R.',
        userEmail: 'mike@example.com',
        rating: 4.0,
        title: 'Good quality, great cause',
        comment: 'These sneakers are well-made and comfortable. It\'s incredible to think they\'re made from cigarette butts! They run a bit small, so order half a size up.',
        createdAt: DateTime.now().subtract(Duration(days: 12)),
        isVerifiedPurchase: true,
        helpfulCount: 8,
      ),
      Review(
        id: '3',
        productId: '2',
        userName: 'Emma L.',
        userEmail: 'emma@example.com',
        rating: 5.0,
        title: 'Perfect for city walking',
        comment: 'These boots are fantastic! I walk a lot in the city and they provide great support and comfort. Love the sustainable materials and the style is perfect.',
        createdAt: DateTime.now().subtract(Duration(days: 8)),
        isVerifiedPurchase: true,
        helpfulCount: 15,
      ),
      Review(
        id: '4',
        productId: '3',
        userName: 'John D.',
        userEmail: 'john@example.com',
        rating: 4.0,
        title: 'Comfortable everyday shoes',
        comment: 'Very comfortable for daily wear. The slip-on design is convenient and they look good with casual outfits. Great to support sustainable fashion.',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isVerifiedPurchase: true,
        helpfulCount: 6,
      ),
    ];
  }

  static List<Review> getReviewsForProduct(String productId) {
    return getSampleReviews().where((review) => review.productId == productId).toList();
  }
}