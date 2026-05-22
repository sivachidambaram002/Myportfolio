// lib/widgets/sections/resume_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;

import '../core/constants.dart';
import '../core/theme.dart';
import '../utils/responsive.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/gradient_button.dart';
import '../widgets/common/section_title.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  // DOWNLOAD RESUME
  Future<void> _downloadResume() async {
    final anchor = html.AnchorElement(
      href: '/${AppConstants.resumeAsset}',
    )
      ..target = 'blank'
      ..download = 'K_Sivachidambaram_Resume.pdf'
      ..click();
  }

  // VIEW RESUME
  Future<void> _viewResume() async {
    html.window.open(
      '/${AppConstants.resumeAsset}',
      '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
      ).add(
        Responsive.horizontalPadding(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.surface.withOpacity(0.4),
            AppColors.background,
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: 'Resume',
            title: 'Download My Resume',
            subtitle:
                'Get a comprehensive overview of my skills, experience and projects.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            child: isMobile
                ? _ResumeCardMobile(
                    onDownload: _downloadResume,
                    onView: _viewResume,
                  )
                : _ResumeCardDesktop(
                    onDownload: _downloadResume,
                    onView: _viewResume,
                  ),
          ),
        ],
      ),
    );
  }
}

class _ResumeCardDesktop extends StatelessWidget {
  final VoidCallback onDownload;
  final VoidCallback onView;

  const _ResumeCardDesktop({
    required this.onDownload,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: GlassCard(
            enableHover: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ResumePreviewMock(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ResumeInfo(),
              const SizedBox(height: 32),
              GradientButton(
                label: 'Download Resume (PDF)',
                icon: Icons.download_rounded,
                onTap: onDownload,
              ),
              const SizedBox(height: 16),
              GradientButton(
                label: 'View Resume Online',
                icon: Icons.open_in_new_rounded,
                onTap: onView,
                outline: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResumeCardMobile extends StatelessWidget {
  final VoidCallback onDownload;
  final VoidCallback onView;

  const _ResumeCardMobile({
    required this.onDownload,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          enableHover: false,
          child: _ResumePreviewMock(),
        ),
        const SizedBox(height: 24),
        _ResumeInfo(),
        const SizedBox(height: 24),
        GradientButton(
          label: 'Download Resume (PDF)',
          icon: Icons.download_rounded,
          onTap: onDownload,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        GradientButton(
          label: 'View Resume Online',
          icon: Icons.open_in_new_rounded,
          onTap: onView,
          outline: true,
          width: double.infinity,
        ),
      ],
    );
  }
}

class _ResumePreviewMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0x1500D4FF),
                    Color(0x157B2FFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConstants.role,
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            ..._mockSections(),
          ],
        ),
      ),
    );
  }

  List<Widget> _mockSections() {
    final sections = [
      ('Professional Summary', 3),
      ('Technical Skills', 5),
      ('Work Experience', 6),
      ('Projects', 4),
      ('Education', 2),
    ];

    return sections.map((section) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              width: 90,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 6),
            ...List.generate(
              section.$2,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: FractionallySizedBox(
                  widthFactor: 0.55 + (index % 3) * 0.15,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class _ResumeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final highlights = [
      ('Flutter & Dart', Icons.phone_android_rounded),
      ('Riverpod + Clean Architecture', Icons.architecture_rounded),
      ('2 Live Play Store Apps', Icons.store_rounded),
      ('REST APIs + Firebase', Icons.cloud_rounded),
      ('Razorpay + Google Maps', Icons.payment_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return AppColors.heroGradient.createShader(bounds);
          },
          child: Text(
            'K. Sivachidambaram',
            style: GoogleFonts.spaceGrotesk(
              fontSize: isMobile ? 22 : 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter Application Developer · 2 Years Experience',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Resume Highlights',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...highlights.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.$2,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.$1,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
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
