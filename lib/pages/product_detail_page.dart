import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/navbar.dart';
import '../components/footer.dart';
import '../models/products.dart';
import '../models/review.dart';
import '../utils/cart_provider.dart';
import 'package:ecocig/components/product_card.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  late Product product;
  late List<Review> reviews;
  int selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    product = ProductData.getSampleProducts().firstWhere((p) => p.id == widget.productId);
    reviews = ReviewData.getReviewsForProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductHeader(),
            _buildProductDetails(),
            _buildReviewsSection(),
            _buildRelatedProducts(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Container(
      padding: const EdgeInsets.all(64),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedImageIndex == index ? Colors.green[600]! : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < product.rating.floor() ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text('${product.rating} (${product.reviewCount} reviews)'),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[700]),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.eco, color: Colors.green[600]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          product.impactDescription,
                          style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(product.description, style: const TextStyle(fontSize: 16, height: 1.6)),
                const SizedBox(height: 24),
                const Text(
                  'Features',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...product.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.green[600], size: 16),
                          const SizedBox(width: 8),
                          Text(feature),
                        ],
                      ),
                    )),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CartProvider>().addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text('Add to Cart', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CartProvider>().addItem(product);
                          Navigator.pushNamed(context, '/cart');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text('Buy Now', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      padding: const EdgeInsets.all(64),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'Product Details',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[800]),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  'Environmental Impact',
                  '${product.recycledCigaretteButts} cigarette butts recycled per pair',
                  Icons.eco,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildDetailCard(
                  'Manufacturing',
                  'Ethically produced using sustainable practices',
                  Icons.factory,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildDetailCard(
                  'Quality Guarantee',
                  '2-year warranty on all products',
                  Icons.verified,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.green[600]),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(height: 1.5), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Container(
      padding: const EdgeInsets.all(64),
      child: Column(
        children: [
          Text(
            'Customer Reviews',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[800]),
          ),
          const SizedBox(height: 32),
          ...reviews.map(_buildReviewCard),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showReviewDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Write a Review'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(review.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating.floor() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment),
            const SizedBox(height: 8),
            Text(
              review.timeAgo,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Write a Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Rate this product:'),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review submitted!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    final relatedProducts = ProductData.getSampleProducts()
        .where((p) => p.id != product.id)
        .take(3)
        .toList();

    return Container(
      padding: const EdgeInsets.all(64),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'You Might Also Like',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[800]),
          ),
          const SizedBox(height: 32),
          Row(
            children: relatedProducts
                .map((related) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: ProductCard(product: related),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
