// lib/core/utils/responsive.dart

import 'package:flutter/material.dart';

import '../core/constants.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppConstants.desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double maxContentWidth(BuildContext context) {
    final w = screenWidth(context);
    if (w > 1400) return 1200;
    if (w > 1200) return 1100;
    return w;
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    final w = screenWidth(context);
    if (w > 1400) return const EdgeInsets.symmetric(horizontal: 80);
    if (w > 1200) return const EdgeInsets.symmetric(horizontal: 60);
    if (w > 900) return const EdgeInsets.symmetric(horizontal: 40);
    if (w > 600) return const EdgeInsets.symmetric(horizontal: 24);
    return const EdgeInsets.symmetric(horizontal: 16);
  }

  static double fontSize(BuildContext context, double desktop, double mobile) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return (desktop + mobile) / 2;
    return desktop;
  }

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? desktop;
    return desktop;
  }
}
