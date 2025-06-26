enum PostTag { diy, events, successStories, awareness, recycling, general }

class CommunityPost {
  final String id;
  final String title;
  final String content;
  final String authorName;
  final String authorEmail;
  final DateTime createdAt;
  final List<PostTag> tags;
  final List<String> imageUrls;
  final int upvotes;
  final int downvotes;
  final int commentsCount;
  final bool isPinned;

  CommunityPost({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.authorEmail,
    required this.createdAt,
    this.tags = const [],
    this.imageUrls = const [],
    this.upvotes = 0,
    this.downvotes = 0,
    this.commentsCount = 0,
    this.isPinned = false,
  });

  int get netVotes => upvotes - downvotes;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'authorName': authorName,
      'authorEmail': authorEmail,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags.map((tag) => tag.toString().split('.').last).toList(),
      'imageUrls': imageUrls,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'commentsCount': commentsCount,
      'isPinned': isPinned,
    };
  }

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      authorName: json['authorName'],
      authorEmail: json['authorEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => PostTag.values.firstWhere((e) => e.toString().split('.').last == tag))
          .toList() ?? [],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      isPinned: json['isPinned'] ?? false,
    );
  }

  CommunityPost copyWith({
    String? id,
    String? title,
    String? content,
    String? authorName,
    String? authorEmail,
    DateTime? createdAt,
    List<PostTag>? tags,
    List<String>? imageUrls,
    int? upvotes,
    int? downvotes,
    int? commentsCount,
    bool? isPinned,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorName: authorName ?? this.authorName,
      authorEmail: authorEmail ?? this.authorEmail,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      imageUrls: imageUrls ?? this.imageUrls,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      commentsCount: commentsCount ?? this.commentsCount,
      isPinned: isPinned ?? this.isPinned,
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

  String get tagsDisplay {
    return tags.map((tag) => '#${tag.toString().split('.').last}').join(' ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CommunityPost && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CommunityPost(id: $id, title: $title, author: $authorName)';
  }
}

class PostComment {
  final String id;
  final String postId;
  final String content;
  final String authorName;
  final String authorEmail;
  final DateTime createdAt;
  final int upvotes;
  final String? parentCommentId; // For nested replies

  PostComment({
    required this.id,
    required this.postId,
    required this.content,
    required this.authorName,
    required this.authorEmail,
    required this.createdAt,
    this.upvotes = 0,
    this.parentCommentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'content': content,
      'authorName': authorName,
      'authorEmail': authorEmail,
      'createdAt': createdAt.toIso8601String(),
      'upvotes': upvotes,
      'parentCommentId': parentCommentId,
    };
  }

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      id: json['id'],
      postId: json['postId'],
      content: json['content'],
      authorName: json['authorName'],
      authorEmail: json['authorEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      upvotes: json['upvotes'] ?? 0,
      parentCommentId: json['parentCommentId'],
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
    return other is PostComment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Sample community posts data
class CommunityPostData {
  static List<CommunityPost> getSamplePosts() {
    return [
      CommunityPost(
        id: '1',
        title: 'Amazing DIY Project: Cigarette Butt Planters!',
        content: 'I collected cigarette butts from my neighborhood and created these beautiful planters. Here\'s how you can do it too:\n\n1. Collect and clean cigarette butts\n2. Mix with soil and organic matter\n3. Use as base for small plants\n\nThey\'re perfect for herbs and small flowers!',
        authorName: 'Green Thumb Sara',
        authorEmail: 'sara@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        tags: [PostTag.diy, PostTag.recycling],
        imageUrls: ['https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400'],
        upvotes: 45,
        downvotes: 2,
        commentsCount: 12,
        isPinned: true,
      ),
      CommunityPost(
        id: '2',
        title: 'Community Cleanup Success Story',
        content: 'Our team collected over 5,000 cigarette butts from the city park last weekend! Thanks to everyone who participated. We\'re sending these to Eco-Cig for recycling into new products.\n\nNext cleanup is scheduled for next month - who\'s in?',
        authorName: 'Cleanup Coordinator Mike',
        authorEmail: 'mike@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        tags: [PostTag.events, PostTag.successStories],
        imageUrls: [
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
          'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400'
        ],
        upvotes: 78,
        downvotes: 1,
        commentsCount: 23,
      ),
      CommunityPost(
        id: '3',
        title: 'The Environmental Impact You Need to Know',
        content: 'Did you know that cigarette butts are the most littered item worldwide? Here are some shocking facts:\n\n• 4.5 trillion butts are littered annually\n• They take 10-12 years to decompose\n• They contain over 70 toxic chemicals\n• They pollute our waterways and harm marine life\n\nTogether, we can make a difference!',
        authorName: 'Eco Warrior Priya',
        authorEmail: 'priya@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 8)),
        tags: [PostTag.awareness],
        upvotes: 92,
        downvotes: 5,
        commentsCount: 34,
      ),
      CommunityPost(
        id: '4',
        title: 'My Experience with Eco-Cig Shoes',
        content: 'I\'ve been wearing my Eco-Runner sneakers for 3 months now, and I\'m impressed! They\'re comfortable, durable, and I love knowing they\'re made from recycled cigarette butts.\n\nThe grip is excellent for running, and they still look great after regular use. Highly recommend!',
        authorName: 'Runner John',
        authorEmail: 'john@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 12)),
        tags: [PostTag.successStories],
        upvotes: 67,
        downvotes: 3,
        commentsCount: 18,
      ),
      CommunityPost(
        id: '5',
        title: 'Organizing School Awareness Program',
        content: 'I\'m planning to organize an awareness program at local schools about cigarette butt pollution. Looking for volunteers and resources.\n\nWho has experience with educational outreach? Any tips for making it engaging for students?',
        authorName: 'Teacher Emma',
        authorEmail: 'emma@example.com',
        createdAt: DateTime.now().subtract(Duration(hours: 18)),
        tags: [PostTag.awareness, PostTag.events],
        upvotes: 34,
        downvotes: 0,
        commentsCount: 15,
      ),
    ];
  }

  static List<PostComment> getSampleComments() {
    return [
      PostComment(
        id: '1',
        postId: '1',
        content: 'This is amazing! I\'m definitely trying this at home. Do you have any tips for cleaning the butts properly?',
        authorName: 'Garden Lover',
        authorEmail: 'gardener@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        upvotes: 8,
      ),
      PostComment(
        id: '2',
        postId: '1',
        content: 'Great idea! I\'d love to see a step-by-step video tutorial.',
        authorName: 'DIY Enthusiast',
        authorEmail: 'diy@example.com',
        createdAt: DateTime.now().subtract(Duration(hours: 12)),
        upvotes: 5,
      ),
      PostComment(
        id: '3',
        postId: '2',
        content: 'Count me in for the next cleanup! Where do I sign up?',
        authorName: 'Volunteer Ready',
        authorEmail: 'volunteer@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 4)),
        upvotes: 12,
      ),
    ];
  }

  static List<PostComment> getCommentsForPost(String postId) {
    return getSampleComments().where((comment) => comment.postId == postId).toList();
  }

  static List<CommunityPost> getPostsByTag(PostTag tag) {
    return getSamplePosts().where((post) => post.tags.contains(tag)).toList();
  }
}