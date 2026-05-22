// lib/widgets/common/section_title.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0x2200D4FF),
                  Color(0x227B2FFF),
                ],
              ),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: Text(
              label.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 2.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Main title with gradient
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.heroGradient.createShader(bounds),
            child: Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child: Text(
                subtitle!,
                style: GoogleFonts.dmSans(
                  fontSize: isMobile ? 14 : 16,
                  color: AppColors.textSecondary,
                  height: 1.7,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 8),
          // Divider line
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
