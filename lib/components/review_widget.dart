import 'package:flutter/material.dart';

class ReviewWidget extends StatefulWidget {
  final String productId;
  const ReviewWidget({super.key, required this.productId});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  int selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool isSubmitting = false;

  // Mock reviews data
  List<Review> reviews = [
    Review(
      id: '1',
      userName: 'Sarah M.',
      rating: 5,
      comment: 'Amazing quality! Love knowing these shoes are made from recycled materials. Super comfortable too!',
      date: DateTime.now().subtract(Duration(days: 3)),
      isVerifiedPurchase: true,
    ),
    Review(
      id: '2',
      userName: 'Mike K.',
      rating: 4,
      comment: 'Great concept and execution. The shoes feel sturdy and the design is sleek. Happy to support the eco mission!',
      date: DateTime.now().subtract(Duration(days: 7)),
      isVerifiedPurchase: true,
    ),
    Review(
      id: '3',
      userName: 'Emma L.',
      rating: 5,
      comment: 'These are my new favorite shoes! Comfortable, stylish, and eco-friendly. What more could you want?',
      date: DateTime.now().subtract(Duration(days: 14)),
      isVerifiedPurchase: false,
    ),
    Review(
      id: '4',
      userName: 'David R.',
      rating: 4,
      comment: 'Impressed with the quality considering they\'re made from cigarette waste. Good job on the sustainability front!',
      date: DateTime.now().subtract(Duration(days: 21)),
      isVerifiedPurchase: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviews Summary
          _buildReviewSummary(),
          SizedBox(height: 32),
          
          // Write a Review Section
          _buildWriteReviewSection(),
          SizedBox(height: 32),
          
          // Reviews List
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildReviewSummary() {
    double averageRating = reviews.isEmpty ? 0 : 
      reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;
    
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Average Rating
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              _buildStarRating(averageRating.round(), size: 20),
              SizedBox(height: 4),
              Text(
                '${reviews.length} reviews',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(width: 40),
          
          // Rating Distribution
          Expanded(
            child: Column(
              children: [
                for (int i = 5; i >= 1; i--)
                  _buildRatingBar(i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars) {
    int count = reviews.where((r) => r.rating == stars).length;
    double percentage = reviews.isEmpty ? 0 : count / reviews.length;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$stars', style: TextStyle(fontSize: 12)),
          SizedBox(width: 4),
          Icon(Icons.star, size: 12, color: Colors.amber),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildWriteReviewSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          
          // Rating Selection
          Text(
            'Your Rating',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              for (int i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = i;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.star,
                      size: 28,
                      color: i <= selectedRating ? Colors.amber : Colors.grey[300],
                    ),
                  ),
                ),
              SizedBox(width: 8),
              Text(
                _getRatingText(selectedRating),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Review Text
          Text(
            'Your Review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Share your experience with this product...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF4CAF50)),
              ),
            ),
          ),
          SizedBox(height: 16),
          
          // Submit Button
          ElevatedButton(
            onPressed: selectedRating > 0 && _reviewController.text.isNotEmpty
                ? _submitReview
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: isSubmitting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Submit Review',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Reviews',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        for (Review review in reviews)
          _buildReviewCard(review),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF4CAF50),
                child: Text(
                  review.userName[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        if (review.isVerifiedPurchase) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withAlpha(25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Verified Purchase',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        _buildStarRating(review.rating, size: 16),
                        SizedBox(width: 8),
                        Text(
                          _formatDate(review.date),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(int rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            Icons.star,
            size: size,
            color: i <= rating ? Colors.amber : Colors.grey[300],
          ),
      ],
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1: return 'Poor';
      case 2: return 'Fair';
      case 3: return 'Good';
      case 4: return 'Very Good';
      case 5: return 'Excellent';
      default: return '';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).floor()} weeks ago';
    return '${(difference / 30).floor()} months ago';
  }

  void _submitReview() async {
    setState(() {
      isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Add new review to the list
    setState(() {
      reviews.insert(0, Review(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You',
        rating: selectedRating,
        comment: _reviewController.text,
        date: DateTime.now(),
        isVerifiedPurchase: true,
      ));
      
      // Reset form
      selectedRating = 0;
      _reviewController.clear();
      isSubmitting = false;
    });

    // Show success message
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review submitted successfully!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}

class Review {
  final String id;
  final String userName;
  final int rating;
  final String comment;
  final DateTime date;
  final bool isVerifiedPurchase;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.isVerifiedPurchase,
  });
}
