abstract final class AppConstants {
  static const appName = 'Ojas Healing';

  // Firestore collections
  static const usersCollection = 'users';
  static const coursesCollection = 'courses';
  static const sessionsCollection = 'sessions';
  static const bookingsCollection = 'bookings';
  static const postsCollection = 'posts';
  static const servicesCollection = 'services';
  static const availabilityCollection = 'availability';

  // Cloud Run API base URL — replace after Step 34 deployment
  static const apiBaseUrl = 'https://ojas-api-PLACEHOLDER.run.app';

  // Razorpay — replace with live key before release
  static const razorpayKeyId = 'rzp_test_PLACEHOLDER';

  // Subscription plan IDs (must match Razorpay dashboard)
  static const freePlanId = 'free';
  static const premiumMonthlyId = 'premium_monthly';
  static const premiumYearlyId = 'premium_yearly';

  // AI agent rate limits (messages per hour)
  static const freeAiLimit = 20;
  static const premiumAiLimit = 100;
}
