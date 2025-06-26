enum BinStatus { pending, approved, rejected, installed }

class BinLocation {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final String description;
  final BinStatus status;
  final String suggestedBy;
  final DateTime suggestedAt;
  final String? imageUrl;
  final int votesCount;
  final String? reason; // For rejection or additional info

  BinLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    required this.status,
    required this.suggestedBy,
    required this.suggestedAt,
    this.imageUrl,
    this.votesCount = 0,
    this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'description': description,
      'status': status.toString().split('.').last,
      'suggestedBy': suggestedBy,
      'suggestedAt': suggestedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'votesCount': votesCount,
      'reason': reason,
    };
  }

  factory BinLocation.fromJson(Map<String, dynamic> json) {
    return BinLocation(
      id: json['id'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      address: json['address'],
      description: json['description'],
      status: BinStatus.values.firstWhere((e) => e.toString().split('.').last == json['status']),
      suggestedBy: json['suggestedBy'],
      suggestedAt: DateTime.parse(json['suggestedAt']),
      imageUrl: json['imageUrl'],
      votesCount: json['votesCount'] ?? 0,
      reason: json['reason'],
    );
  }

  BinLocation copyWith({
    String? id,
    double? latitude,
    double? longitude,
    String? address,
    String? description,
    BinStatus? status,
    String? suggestedBy,
    DateTime? suggestedAt,
    String? imageUrl,
    int? votesCount,
    String? reason,
  }) {
    return BinLocation(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      description: description ?? this.description,
      status: status ?? this.status,
      suggestedBy: suggestedBy ?? this.suggestedBy,
      suggestedAt: suggestedAt ?? this.suggestedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      votesCount: votesCount ?? this.votesCount,
      reason: reason ?? this.reason,
    );
  }

  String get statusDisplay {
    switch (status) {
      case BinStatus.pending:
        return 'Pending Review';
      case BinStatus.approved:
        return 'Approved';
      case BinStatus.rejected:
        return 'Rejected';
      case BinStatus.installed:
        return 'Installed';
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(suggestedAt);

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
    return other is BinLocation && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'BinLocation(id: $id, address: $address, status: $status)';
  }
}

// Sample bin locations data
class BinLocationData {
  static List<BinLocation> getSampleLocations() {
    return [
      BinLocation(
        id: '1',
        latitude: 11.0168,
        longitude: 76.9558,
        address: 'RS Puram, Coimbatore, Tamil Nadu',
        description: 'High foot traffic area near shopping complex. Many smokers gather here.',
        status: BinStatus.installed,
        suggestedBy: 'Raj Kumar',
        suggestedAt: DateTime.now().subtract(Duration(days: 30)),
        imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400',
        votesCount: 45,
      ),
      BinLocation(
        id: '2',
        latitude: 11.0041,
        longitude: 76.9597,
        address: 'Gandhipuram, Coimbatore, Tamil Nadu',
        description: 'Bus stop area with heavy smoking activity. Needs urgent attention.',
        status: BinStatus.approved,
        suggestedBy: 'Priya S.',
        suggestedAt: DateTime.now().subtract(Duration(days: 15)),
        votesCount: 32,
      ),
      BinLocation(
        id: '3',
        latitude: 11.0183,
        longitude: 77.0072,
        address: 'Peelamedu, Coimbatore, Tamil Nadu',
        description: 'College area with students smoking. Educational opportunity for awareness.',
        status: BinStatus.pending,
        suggestedBy: 'Arun M.',
        suggestedAt: DateTime.now().subtract(Duration(days: 7)),
        imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
        votesCount: 18,
      ),
      BinLocation(
        id: '4',
        latitude: 11.0510,
        longitude: 76.9990,
        address: 'Saibaba Colony, Coimbatore, Tamil Nadu',
        description: 'Park entrance where people smoke before entering.',
        status: BinStatus.rejected,
        suggestedBy: 'Meera L.',
        suggestedAt: DateTime.now().subtract(Duration(days: 20)),
        votesCount: 8,
        reason: 'Park management declined permission',
      ),
      BinLocation(
        id: '5',
        latitude: 10.9965,
        longitude: 76.9547,
        address: 'Town Hall, Coimbatore, Tamil Nadu',
        description: 'Government office area with smoking zones nearby.',
        status: BinStatus.pending,
        suggestedBy: 'Vikram R.',
        suggestedAt: DateTime.now().subtract(Duration(days: 3)),
        votesCount: 12,
      ),
    ];
  }

  static List<BinLocation> getLocationsByStatus(BinStatus status) {
    return getSampleLocations().where((location) => location.status == status).toList();
  }
}