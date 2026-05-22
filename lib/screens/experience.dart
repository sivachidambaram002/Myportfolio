// lib/widgets/sections/experience_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme.dart';
import '../utils/responsive.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100)
          .add(Responsive.horizontalPadding(context)),
      child: Column(
        children: [
          const SectionTitle(
            label: 'Experience',
            title: 'Work Experience',
            subtitle:
                'Professional journey building production-grade Flutter applications.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            child: const _ExperienceCard(),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 700),
            child: isMobile
                ? const _AchievementsMobile()
                : const _AchievementsDesktop(),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final responsibilities = [
      'Independently developed and shipped 2 production Flutter apps for Android & iOS, both live on Google Play Store with active users.',
      'Architected feature modules using Riverpod state management following Clean Architecture (data / domain / presentation layers), ensuring scalable and maintainable codebases.',
      'Optimised app startup time by ~35% through lazy-loading non-critical widgets and Hive local storage caching.',
      'Implemented OTP authentication with Firebase Auth and JWT token refresh logic, reducing session timeout errors by 90%.',
      'Integrated Razorpay payment gateway for in-app booking payments with real-time order callbacks and error handling.',
      'Configured Firebase FCM push notifications for real-time booking status updates and alerts.',
      'Led end-to-end mobile app delivery: Figma handoff → REST API integration → QA → Play Store → TestFlight.',
      'Integrated Google Maps API for real-time pickup/delivery location tracking in driver-facing applications.',
      'Collaborated with Node.js backend team to design and consume REST APIs for booking and user management.',
    ];

    return GlassCard(
      enableHover: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CompanyBadge(),
                    const SizedBox(height: 16),
                    _RoleInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _RoleInfo()),
                    _CompanyBadge(),
                  ],
                ),
          const SizedBox(height: 24),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 24),
          // Responsibilities
          Text(
            'Key Responsibilities & Achievements',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...responsibilities.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      r,
                      style: GoogleFonts.dmSans(
                        fontSize: isMobile ? 13 : 14,
                        color: AppColors.textSecondary,
                        height: 1.65,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            'Flutter Application Developer',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Klix Tech · Anna Nagar, Chennai, TN',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _Tag(
                label: 'Jun 2024 – Present',
                icon: Icons.calendar_today_outlined,
                color: AppColors.success),
            const SizedBox(width: 10),
            _Tag(
                label: 'Full-time',
                icon: Icons.work_outline_rounded,
                color: AppColors.primary),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _Tag({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            'KLIX',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          Text(
            'TECH',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementsDesktop extends StatelessWidget {
  const _AchievementsDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
            child: _AchievementCard(
          icon: Icons.rocket_launch_rounded,
          value: '35%',
          label: 'App Startup Improvement',
          desc: 'Optimised via lazy-loading and Hive caching',
          color: Color(0xFF00D4FF),
        )),
        SizedBox(width: 16),
        Expanded(
            child: _AchievementCard(
          icon: Icons.bug_report_outlined,
          value: '90%',
          label: 'Session Timeout Reduction',
          desc: 'Through JWT refresh & Firebase Auth',
          color: Color(0xFF00FFB3),
        )),
        SizedBox(width: 16),
        Expanded(
            child: _AchievementCard(
          icon: Icons.store_rounded,
          value: '2',
          label: 'Live Play Store Apps',
          desc: 'Both actively used in production',
          color: Color(0xFF7B2FFF),
        )),
        SizedBox(width: 16),
        Expanded(
            child: _AchievementCard(
          icon: Icons.layers_rounded,
          value: '100%',
          label: 'Clean Architecture',
          desc: 'All modules follow MVVM & DDD',
          color: Color(0xFFFFD93D),
        )),
      ],
    );
  }
}

class _AchievementsMobile extends StatelessWidget {
  const _AchievementsMobile();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: const [
        _AchievementCard(
          icon: Icons.rocket_launch_rounded,
          value: '35%',
          label: 'Startup Boost',
          desc: 'Lazy-load & Hive cache',
          color: Color(0xFF00D4FF),
        ),
        _AchievementCard(
          icon: Icons.bug_report_outlined,
          value: '90%',
          label: 'Timeout Reduction',
          desc: 'JWT + Firebase Auth',
          color: Color(0xFF00FFB3),
        ),
        _AchievementCard(
          icon: Icons.store_rounded,
          value: '2',
          label: 'Live Apps',
          desc: 'On Google Play Store',
          color: Color(0xFF7B2FFF),
        ),
        _AchievementCard(
          icon: Icons.layers_rounded,
          value: '100%',
          label: 'Clean Code',
          desc: 'MVVM Architecture',
          color: Color(0xFFFFD93D),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String desc;
  final Color color;

  const _AchievementCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (b) => LinearGradient(
              colors: [color, color.withOpacity(0.7)],
            ).createShader(b),
            child: Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
