// lib/core/constants/portfolio_data.dart

import 'package:flutter/material.dart';
import '../models/skill_model.dart';

class PortfolioData {
  static final List<SkillCategory> skills = [
    SkillCategory(
      title: 'Mobile Development',
      icon: Icons.phone_android_rounded,
      skills: ['Flutter', 'Dart', 'Android', 'iOS'],
      color: const Color(0xFF00D4FF),
    ),
    SkillCategory(
      title: 'State Management',
      icon: Icons.account_tree_rounded,
      skills: ['Riverpod', 'Provider'],
      color: const Color(0xFF7B2FFF),
    ),
    SkillCategory(
      title: 'Architecture',
      icon: Icons.architecture_rounded,
      skills: ['Clean Architecture', 'MVVM', 'Data/Domain/Presentation'],
      color: const Color(0xFF00FFB3),
    ),
    SkillCategory(
      title: 'Backend & APIs',
      icon: Icons.cloud_rounded,
      skills: [
        'REST APIs',
        'JSON Parsing',
        'Firebase FCM',
        'Push Notifications',
        'Node.js'
      ],
      color: const Color(0xFFFF6B6B),
    ),
    SkillCategory(
      title: 'Authentication',
      icon: Icons.lock_rounded,
      skills: ['OTP Authentication', 'Firebase Auth', 'JWT Token Refresh'],
      color: const Color(0xFFFFD93D),
    ),
    SkillCategory(
      title: 'Payments',
      icon: Icons.payment_rounded,
      skills: ['Razorpay Integration'],
      color: const Color(0xFF4ECDC4),
    ),
    SkillCategory(
      title: 'Database',
      icon: Icons.storage_rounded,
      skills: ['Hive (Local Cache)', 'SQL'],
      color: const Color(0xFFFF9F43),
    ),
    SkillCategory(
      title: 'Maps & Location',
      icon: Icons.map_rounded,
      skills: ['Google Maps API', 'Real-time Tracking'],
      color: const Color(0xFF54A0FF),
    ),
    SkillCategory(
      title: 'Tools & IDEs',
      icon: Icons.build_rounded,
      skills: ['Android Studio', 'VS Code', 'Git', 'GitHub'],
      color: const Color(0xFFA29BFE),
    ),
    SkillCategory(
      title: 'Deployment',
      icon: Icons.rocket_launch_rounded,
      skills: ['Google Play Store', 'TestFlight', 'CI/CD'],
      color: const Color(0xFF00D4FF),
    ),
    SkillCategory(
      title: 'Design',
      icon: Icons.design_services_rounded,
      skills: ['Figma Handoff'],
      color: const Color(0xFFFF6B9D),
    ),
    SkillCategory(
      title: 'Soft Skills',
      icon: Icons.people_rounded,
      skills: [
        'Leadership',
        'Communication',
        'Problem Solving',
        'Adaptability'
      ],
      color: const Color(0xFF7B2FFF),
    ),
  ];

  static final List<ProjectModel> projects = [
    ProjectModel(
      title: 'Kancaroo Car Carriers',
      subtitle: 'Customer App',
      description:
          'Production-grade customer-facing Flutter app for car carrier booking with real-time status tracking, seamless payment integration, and push notification support.',
      techStack: ['Flutter', 'Riverpod', 'REST APIs', 'Firebase', 'Razorpay'],
      features: [
        'OTP Login & Authentication',
        'Multi-step Booking Forms',
        'Real-time Booking Status',
        'Push Notifications (FCM)',
        'Razorpay Payment Gateway',
        'Clean Architecture (MVVM)',
      ],
      status: 'Live on Play Store',
    ),
    ProjectModel(
      title: 'Kancaroo Car Carriers',
      subtitle: 'Driver App',
      description:
          'Driver-side Flutter application for managing car pickup and delivery operations with Google Maps integration, live tracking, and route optimization.',
      techStack: ['Flutter', 'Riverpod', 'Google Maps API', 'REST APIs'],
      features: [
        'Real-time Location Tracking',
        'Google Maps Integration',
        'Driver Status Management',
        'Delivery Tracking Dashboard',
        'Route Optimization',
        'Booking Updates via API',
      ],
      status: 'Live on Play Store',
    ),
    ProjectModel(
      title: 'Hotel Tips Management',
      subtitle: 'Staff Analytics App',
      description:
          'Mobile application to manage and track hotel staff tips with role-based access, interactive data visualization dashboards, and real-time alerts.',
      techStack: ['Flutter', 'REST APIs', 'Firebase', 'Flutter Charts'],
      features: [
        'Role-based Login & Access',
        'Interactive Data Visualization',
        'Monthly & Yearly Graph Reports',
        'Dynamic Date-range Filtering',
        'Firebase FCM Notifications',
        'REST API Integration',
      ],
      status: 'Completed',
    ),
  ];

  static final List<EventModel> events = [
    EventModel(
      title: 'PayPal Flutter Event',
      organizer: 'PayPal',
      description:
          'Attended PayPal-organized Flutter developer event exploring payment integrations and Flutter ecosystem advancements.',
      imagePath: 'assets/images/event_paypal.jpg',
    ),
    EventModel(
      title: 'Comcast Tech Event',
      organizer: 'Comcast',
      description:
          'Participated in Comcast technology event covering cutting-edge mobile and web technologies.',
      imagePath: 'assets/images/event_comcast.jpg',
    ),
    EventModel(
      title: 'Adobe Developer Event',
      organizer: 'Adobe',
      description:
          'Engaged with Adobe developer community exploring design tools, workflows, and Figma integration techniques.',
      imagePath: 'assets/images/event_adobe.jpg',
    ),
  ];
}
