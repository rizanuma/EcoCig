import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Analytics {
  static final Analytics _instance = Analytics._internal();
  factory Analytics() => _instance;
  Analytics._internal();

  bool _isInitialized = false;
  String? _userId;
  final Map<String, dynamic> _userProperties = {};

  // Initialize analytics
  Future<void> initialize({
    String? googleAnalyticsId,
    String? hotjarId,
    String? clarityId,
  }) async {
    if (_isInitialized) return;

    try {
      if (kIsWeb) {
        // Initialize Google Analytics
        if (googleAnalyticsId != null) {
          await _initializeGoogleAnalytics(googleAnalyticsId);
        }

        // Initialize Microsoft Clarity
        if (clarityId != null) {
          await _initializeClarity(clarityId);
        }

        // Initialize Hotjar
        if (hotjarId != null) {
          await _initializeHotjar(hotjarId);
        }
      }

      _isInitialized = true;
      if (kDebugMode) {
        print('Analytics initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize analytics: $e');
      }
    }
  }

  // Track page views
  void trackPageView(String pageName, {Map<String, dynamic>? parameters}) {
    if (!_isInitialized) return;

    final eventData = {
      'page_title': pageName,
      'page_location': '/${pageName.toLowerCase().replaceAll(' ', '_')}',
      'timestamp': DateTime.now().toIso8601String(),
      ...?parameters,
    };

    if (kIsWeb) {
      _sendToGoogleAnalytics('page_view', eventData);
      _sendToClarity('pageView', eventData);
    }

    _logEvent('PAGE_VIEW', eventData);
  }

  // Track user interactions
  void trackEvent(String eventName, {Map<String, dynamic>? parameters}) {
    if (!_isInitialized) return;

    final eventData = {
      'event_category': 'user_interaction',
      'event_label': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'user_id': _userId,
      ...?parameters,
    };

    if (kIsWeb) {
      _sendToGoogleAnalytics(eventName, eventData);
      _sendToClarity('event', eventData);
    }

    _logEvent('CUSTOM_EVENT', eventData);
  }

  // Track button clicks
  void trackButtonClick(String buttonName, {String? location}) {
    trackEvent('button_click', parameters: {
      'button_name': buttonName,
      'button_location': location ?? 'unknown',
    });
  }

  // Track form submissions
  void trackFormSubmission(String formName, {bool successful = true}) {
    trackEvent('form_submission', parameters: {
      'form_name': formName,
      'successful': successful,
    });
  }

  // Track downloads
  void trackDownload(String fileName, String fileType) {
    trackEvent('file_download', parameters: {
      'file_name': fileName,
      'file_type': fileType,
    });
  }

  // Track search actions
  void trackSearch(String searchTerm, {int? resultCount}) {
    trackEvent('search', parameters: {
      'search_term': searchTerm,
      'result_count': resultCount,
    });
  }

  // Track product interactions
  void trackProductView(String productId, String productName) {
    trackEvent('view_item', parameters: {
      'item_id': productId,
      'item_name': productName,
      'content_type': 'product',
    });
  }

  void trackAddToCart(String productId, String productName, double price) {
    trackEvent('add_to_cart', parameters: {
      'item_id': productId,
      'item_name': productName,
      'price': price,
      'currency': 'USD',
    });
  }

  void trackPurchase(String transactionId, double value, List<Map<String, dynamic>> items) {
    trackEvent('purchase', parameters: {
      'transaction_id': transactionId,
      'value': value,
      'currency': 'USD',
      'items': items,
    });
  }

  // Track bin location suggestions
  void trackBinSuggestion(double latitude, double longitude, String address) {
    trackEvent('bin_suggestion', parameters: {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
  }

  // Track community interactions
  void trackCommunityPost(String postType, {String? category}) {
    trackEvent('community_post', parameters: {
      'post_type': postType,
      'category': category,
    });
  }

  void trackCommunityVote(String postId, String voteType) {
    trackEvent('community_vote', parameters: {
      'post_id': postId,
      'vote_type': voteType, // 'upvote' or 'downvote'
    });
  }

  // Track user engagement
  void trackTimeOnPage(String pageName, Duration timeSpent) {
    trackEvent('time_on_page', parameters: {
      'page_name': pageName,
      'time_spent_seconds': timeSpent.inSeconds,
    });
  }

  void trackScrollDepth(String pageName, double scrollPercentage) {
    trackEvent('scroll_depth', parameters: {
      'page_name': pageName,
      'scroll_percentage': scrollPercentage,
    });
  }

  // Set user properties
  void setUserId(String userId) {
    _userId = userId;
    _userProperties['user_id'] = userId;
    
    if (kIsWeb) {
      _sendUserPropertiesToAnalytics();
    }
  }

  void setUserProperty(String key, dynamic value) {
    _userProperties[key] = value;
    
    if (kIsWeb) {
      _sendUserPropertiesToAnalytics();
    }
  }

  // Track errors
  void trackError(String errorMessage, {String? errorCode, String? location}) {
    trackEvent('error', parameters: {
      'error_message': errorMessage,
      'error_code': errorCode,
      'error_location': location,
    });
  }

  // Performance tracking
  void trackPerformance(String metricName, double value, {String? unit}) {
    trackEvent('performance_metric', parameters: {
      'metric_name': metricName,
      'metric_value': value,
      'metric_unit': unit ?? 'ms',
    });
  }

  // Private methods for web analytics integration
  Future<void> _initializeGoogleAnalytics(String analyticsId) async {
    // This would normally load the Google Analytics script
    // For Flutter web, you'd add this to your index.html
    if (kDebugMode) {
      print('Google Analytics initialized with ID: $analyticsId');
    }
  }

  Future<void> _initializeClarity(String clarityId) async {
    // This would normally load the Microsoft Clarity script
    if (kDebugMode) {
      print('Microsoft Clarity initialized with ID: $clarityId');
    }
  }

  Future<void> _initializeHotjar(String hotjarId) async {
    // This would normally load the Hotjar script
    if (kDebugMode) {
      print('Hotjar initialized with ID: $hotjarId');
    }
  }

  void _sendToGoogleAnalytics(String eventName, Map<String, dynamic> data) {
    // In a real implementation, this would call the gtag function
    if (kDebugMode) {
      print('Google Analytics Event: $eventName - $data');
    }
  }

  void _sendToClarity(String eventType, Map<String, dynamic> data) {
    // In a real implementation, this would call the clarity function
    if (kDebugMode) {
      print('Microsoft Clarity Event: $eventType - $data');
    }
  }

  void _sendUserPropertiesToAnalytics() {
    if (kDebugMode) {
      print('User Properties Updated: $_userProperties');
    }
  }

  void _logEvent(String eventType, Map<String, dynamic> data) {
    if (kDebugMode) {
      print('Analytics Event [$eventType]: $data');
    }
  }

  // Utility methods
  Map<String, dynamic> get userProperties => Map.from(_userProperties);
  String? get userId => _userId;
  bool get isInitialized => _isInitialized;
}

// Extension for easier tracking
extension AnalyticsExtension on Widget {
  Widget withAnalytics(String eventName, {Map<String, dynamic>? parameters}) {
    return GestureDetector(
      onTap: () => Analytics().trackEvent(eventName, parameters: parameters),
      child: this,
    );
  }
}

// Mixin for page tracking
mixin AnalyticsPageMixin<T extends StatefulWidget> on State<T> {
  String get pageName;
  DateTime? _pageEnterTime;

  @override
  void initState() {
    super.initState();
    _pageEnterTime = DateTime.now();
    Analytics().trackPageView(pageName);
  }

  @override
  void dispose() {
    if (_pageEnterTime != null) {
      final timeSpent = DateTime.now().difference(_pageEnterTime!);
      Analytics().trackTimeOnPage(pageName, timeSpent);
    }
    super.dispose();
  }
}

// Custom analytics events for Eco-Cig specific actions
class EcoCigAnalytics {
  static final Analytics _analytics = Analytics();

  static void trackEcoMissionEngagement(String engagementType) {
    _analytics.trackEvent('eco_mission_engagement', parameters: {
      'engagement_type': engagementType,
    });
  }

  static void trackRecyclingEducation(String contentType, String contentId) {
    _analytics.trackEvent('recycling_education', parameters: {
      'content_type': contentType,
      'content_id': contentId,
    });
  }

  static void trackSustainabilityGoal(String goalType, bool achieved) {
    _analytics.trackEvent('sustainability_goal', parameters: {
      'goal_type': goalType,
      'achieved': achieved,
    });
  }

  static void trackEnvironmentalImpact(String impactType, double value) {
    _analytics.trackEvent('environmental_impact', parameters: {
      'impact_type': impactType,
      'impact_value': value,
    });
  }

  static void trackPartnershipInquiry(String partnershipType) {
    _analytics.trackEvent('partnership_inquiry', parameters: {
      'partnership_type': partnershipType,
    });
  }
}