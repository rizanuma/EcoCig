class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> materials;
  final int recycledCigaretteButts;
  final String impactDescription;
  final List<String> features;
  final bool isAvailable;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final List<String> colors;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.materials,
    required this.recycledCigaretteButts,
    required this.impactDescription,
    this.features = const [],
    this.isAvailable = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.sizes = const [],
    this.colors = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'category': category,
        'materials': materials,
        'recycledCigaretteButts': recycledCigaretteButts,
        'impactDescription': impactDescription,
        'features': features,
        'isAvailable': isAvailable,
        'rating': rating,
        'reviewCount': reviewCount,
        'sizes': sizes,
        'colors': colors,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'].toDouble(),
        imageUrl: json['imageUrl'],
        category: json['category'],
        materials: List<String>.from(json['materials']),
        recycledCigaretteButts: json['recycledCigaretteButts'],
        impactDescription: json['impactDescription'],
        features: List<String>.from(json['features'] ?? []),
        isAvailable: json['isAvailable'] ?? true,
        rating: json['rating']?.toDouble() ?? 0.0,
        reviewCount: json['reviewCount'] ?? 0,
        sizes: List<String>.from(json['sizes'] ?? []),
        colors: List<String>.from(json['colors'] ?? []),
      );
}

// Sample products
class ProductData {
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Eco-Runner Sneakers',
        description: 'Sustainable running shoes made from recycled cigarette butts and ocean plastic.',
        price: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
        category: 'Footwear',
        materials: ['Recycled Cigarette Butts', 'Ocean Plastic', 'Organic Cotton'],
        recycledCigaretteButts: 150,
        impactDescription: 'Each pair recycles 150 cigarette butts, reducing ocean waste and landfills.',
        features: ['Breathable design', 'Anti-slip sole', 'Machine washable'],
        rating: 4.5,
        reviewCount: 42,
        sizes: ['6', '7', '8', '9', '10', '11', '12'],
        colors: ['Black', 'White', 'Green'],
      ),
      Product(
        id: '2',
        name: 'Urban Walker Boots',
        description: 'Durable boots crafted from recycled materials for city adventures.',
        price: 129.99,
        imageUrl: 'https://images.unsplash.com/photo-1544966503-7cc5ac882d2e?w=400',
        category: 'Footwear',
        materials: ['Recycled Cigarette Butts', 'Recycled Rubber', 'Hemp'],
        recycledCigaretteButts: 200,
        impactDescription: 'Recycles 200 cigarette butts per pair and supports ethical manufacturing.',
        features: ['Water-resistant', 'High-ankle support', 'Flexible grip'],
        rating: 4.7,
        reviewCount: 38,
        sizes: ['6', '7', '8', '9', '10', '11', '12'],
        colors: ['Brown', 'Black', 'Tan'],
      ),
      Product(
        id: '3',
        name: 'Casual Slip-ons',
        description: 'Comfortable everyday shoes made from sustainable materials.',
        price: 69.99,
        imageUrl: 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=400',
        category: 'Footwear',
        materials: ['Recycled Cigarette Butts', 'Bamboo Fiber', 'Natural Rubber'],
        recycledCigaretteButts: 100,
        impactDescription: 'Helps recycle 100 cigarette butts per pair while staying light on your feet.',
        features: ['Lightweight build', 'Elastic fit', 'Eco-friendly glue'],
        rating: 4.3,
        reviewCount: 67,
        sizes: ['6', '7', '8', '9', '10', '11', '12'],
        colors: ['Navy', 'Gray', 'Beige'],
      ),
      Product(
        id: '4',
        name: 'Sport Sandals',
        description: 'Active sandals perfect for outdoor activities, made from recycled waste.',
        price: 49.99,
        imageUrl: 'https://images.unsplash.com/photo-1506629905870-b4eee3774e71?w=400',
        category: 'Footwear',
        materials: ['Recycled Cigarette Butts', 'Recycled EVA', 'Cork'],
        recycledCigaretteButts: 75,
        impactDescription: '75 cigarette butts per pair saved from landfills and repurposed.',
        features: ['Adjustable straps', 'Quick-dry material', 'Outdoor grip'],
        rating: 4.2,
        reviewCount: 29,
        sizes: ['6', '7', '8', '9', '10', '11', '12'],
        colors: ['Black', 'Green', 'Blue'],
      ),
      Product(
        id: '5',
        name: 'Eco-Formal Shoes',
        description: 'Professional dress shoes that don’t compromise on sustainability.',
        price: 149.99,
        imageUrl: 'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=400',
        category: 'Footwear',
        materials: ['Recycled Cigarette Butts', 'Vegan Leather', 'Cork Sole'],
        recycledCigaretteButts: 180,
        impactDescription: 'Eco-formals recycle 180 cigarette butts and use vegan materials.',
        features: ['Elegant design', 'Comfort padding', 'Stain-resistant'],
        rating: 4.6,
        reviewCount: 23,
        sizes: ['6', '7', '8', '9', '10', '11', '12'],
        colors: ['Black', 'Brown'],
      ),
    ];
  }
}
