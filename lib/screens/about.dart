// lib/widgets/sections/about_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants.dart';
import '../core/theme.dart';
import '../utils/responsive.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
      ).add(Responsive.horizontalPadding(context)),
      child: Column(
        children: [
          const SectionTitle(
            label: 'About Me',
            title: 'Passionate Flutter Engineer',
            subtitle:
                'Building production-grade cross-platform apps that users love.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          isMobile ? _MobileAbout() : _DesktopAbout(),
        ],
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AboutCard(),
                const SizedBox(height: 24),
                _HighlightsRow(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: FadeInRight(
            duration: const Duration(milliseconds: 700),
            child: Column(
              children: const [
                _QuickInfoCard(),
                SizedBox(height: 20),
                _JourneyCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _AboutCard(),
        SizedBox(height: 20),
        _HighlightsRow(),
        SizedBox(height: 20),
        _QuickInfoCard(),
        SizedBox(height: 20),
        _JourneyCard(),
      ],
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return GlassCard(
      enableHover: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person_outline_rounded,
                    color: Colors.black, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Professional Summary',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.summary,
            style: GoogleFonts.dmSans(
              fontSize: isMobile ? 14 : 15,
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightsRow extends StatelessWidget {
  const _HighlightsRow();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final highlights = [
      _Highlight(
          icon: Icons.rocket_launch_rounded,
          label: '2 Apps Live',
          sublabel: 'Play Store',
          color: const Color(0xFF00D4FF)),
      _Highlight(
          icon: Icons.trending_up_rounded,
          label: '35% Faster',
          sublabel: 'App Startup',
          color: const Color(0xFF00FFB3)),
      _Highlight(
          icon: Icons.bug_report_outlined,
          label: '90% Less',
          sublabel: 'Timeout Bugs',
          color: const Color(0xFF7B2FFF)),
    ];

    return isMobile
        ? Column(
            children: highlights
                .map((h) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _HighlightCard(h: h),
                    ))
                .toList(),
          )
        : Row(
            children: highlights
                .map((h) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _HighlightCard(h: h),
                      ),
                    ))
                .toList(),
          );
  }
}

class _Highlight {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;

  const _Highlight(
      {required this.icon,
      required this.label,
      required this.sublabel,
      required this.color});
}

class _HighlightCard extends StatelessWidget {
  final _Highlight h;

  const _HighlightCard({required this.h});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: h.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(h.icon, color: h.color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                h.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                h.sublabel,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickInfoCard extends StatelessWidget {
  const _QuickInfoCard();

  @override
  Widget build(BuildContext context) {
    final infos = [
      _Info(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: AppConstants.location),
      _Info(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: AppConstants.phone),
      _Info(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          value: AppConstants.email),
      _Info(
          icon: Icons.work_outline_rounded,
          label: 'Experience',
          value: '${AppConstants.experience} Experience'),
      _Info(
          icon: Icons.school_outlined,
          label: 'Education',
          value: 'BE - Computer Science Engineering'),
    ];

    return GlassCard(
      enableHover: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Info',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...infos.map((i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(i.icon, size: 14, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i.label,
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              color: AppColors.textMuted,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            i.value,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _Info {
  final IconData icon;
  final String label;
  final String value;

  const _Info({required this.icon, required this.label, required this.value});
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHover: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Journey',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _TimelineItem(
            year: '2018–2021',
            title: 'Diploma – Computer Engineering',
            sub: 'MSPVL Polytechnic College · 87%',
            isFirst: true,
          ),
          _TimelineItem(
            year: '2021–2024',
            title: 'BE – Computer Science',
            sub: 'Mepco Schlenk Engineering College',
          ),
          _TimelineItem(
            year: 'Jul 2024',
            title: 'Flutter Bootcamp – Udemy',
            sub: 'Dr. Angela Yu · Completed',
          ),
          _TimelineItem(
            year: 'Jun 2024–Now',
            title: 'Flutter Developer @ Klix Tech',
            sub: 'Anna Nagar, Chennai · Production Apps',
            isLast: true,
            isCurrent: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String sub;
  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  const _TimelineItem({
    required this.year,
    required this.title,
    required this.sub,
    this.isFirst = false,
    this.isLast = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 12,
          child: Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? AppColors.primary : AppColors.borderLight,
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 8,
                          )
                        ]
                      : [],
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 44,
                  color: AppColors.border,
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: isCurrent ? AppColors.primary : AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
