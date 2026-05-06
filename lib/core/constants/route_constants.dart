abstract final class Routes {
  // Splash (initial route — manages its own auth-driven navigation)
  static const splash = '/splash';

  // Top-level auth/onboarding
  static const login = '/login';
  static const phoneOtp = '/phone-otp';
  static const otpVerify = '/otp-verify';
  static const onboarding = '/onboarding';

  // Feature top-levels (outside shell)
  static const aiAgent = '/ai-agent';
  static const wellness = '/wellness';
  static const subscription = '/subscription';

  // Shell branch roots
  static const home = '/home';
  static const learn = '/learn';
  static const live = '/live';
  static const heal = '/heal';
  static const profile = '/profile';

  // Nested under /learn
  static const courseDetail = 'course/:courseId';
  static const lessonPlayer = 'lesson/:lessonId';
  static const audioPlayer = 'audio';
  static const pdfViewer = 'pdf';

  // Nested under /live
  static const sessionDetail = 'session/:sessionId';
  static const liveRoom = 'room/:sessionId';

  // Nested under /heal
  static const serviceDetail = 'service/:serviceId';
  static const bookingCalendar = 'calendar/:serviceId';
  static const bookingConfirmation = 'confirm/:bookingId';
  static const myBookings = 'my-bookings';
  static const videoCall = 'call/:bookingId';

  // Nested under /profile
  static const editProfile = 'edit';
  static const bookmarks = 'bookmarks';
  static const notificationPrefs = 'notifications';
  static const paymentHistory = 'payments';
}
