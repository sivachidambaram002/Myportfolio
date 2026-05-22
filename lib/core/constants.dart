// lib/core/constants/app_constants.dart

class AppConstants {
  // Personal Info
  static const String name = 'K. Sivachidambaram';
  static const String firstName = 'Siva';
  static const String role = 'Flutter Application Developer';
  static const String location = 'Chennai, Tamil Nadu';
  static const String phone = '+91 9092742287';
  static const String email = 'sivachidambaramcse@gmail.com';
  static const String experience = '2 Years';

  // Links
  static const String linkedInUrl =
      'https://www.linkedin.com/in/sivachidambaram-k-i-46b3b8216/';
  static const String githubUrl = 'https://github.com/sivachidambaram002';
  static const String resumeAsset = 'assets/pdf/resume.pdf';

  // Summary
  static const String summary =
      'Flutter Application Developer with 2 years of hands-on production experience '
      'building and shipping cross-platform mobile applications for Android and iOS. '
      'Delivered Flutter applications currently live on Google Play Store. Skilled in '
      'Flutter, Dart, Riverpod state management, Clean Architecture (MVVM), REST API '
      'integration, Firebase FCM push notifications, OTP authentication, and Razorpay '
      'payment gateway integration. Experienced in complete mobile app lifecycle from '
      'Figma handoff to Play Store deployment and iOS TestFlight submission. Passionate '
      'about building scalable, high-performance, and user-friendly applications.';

  // Email JS (FormSubmit endpoint)
  static const String formSubmitEndpoint =
      'https://formsubmit.co/ajax/sivachidambaramcse@gmail.com';

  // Nav Items
  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Events',
    'Resume',
    'Contact',
  ];

  // Nav Anchors
  static const List<String> navAnchors = [
    'home',
    'about',
    'skills',
    'experience',
    'projects',
    'events',
    'resume',
    'contact',
  ];

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}
