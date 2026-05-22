// lib/widgets/sections/skills_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/portfolio_data.dart';
import '../core/theme.dart';
import '../models/skill_model.dart';
import '../utils/responsive.dart';
import '../widgets/common/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossAxis = isMobile
        ? 1
        : Responsive.isTablet(context)
            ? 2
            : 3;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100)
          .add(Responsive.horizontalPadding(context)),
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
            label: 'Technical Skills',
            title: 'My Tech Arsenal',
            subtitle:
                'A comprehensive skill set built through 2 years of production development.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.4 : 1.3,
            ),
            itemCount: PortfolioData.skills.length,
            itemBuilder: (ctx, i) => FadeInUp(
              delay: Duration(milliseconds: 100 * (i % crossAxis)),
              duration: const Duration(milliseconds: 500),
              child: _SkillCard(category: PortfolioData.skills[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillCategory category;

  const _SkillCard({required this.category});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.category.color.withOpacity(0.5)
                : AppColors.border,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _hovered
                ? [
                    widget.category.color.withOpacity(0.08),
                    AppColors.cardBg,
                  ]
                : [
                    AppColors.surfaceElevated,
                    AppColors.cardBg,
                  ],
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.category.color.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: widget.category.color
                        .withOpacity(_hovered ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.category.icon,
                    color: widget.category.color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.category.skills
                    .map((s) => _SkillChip(
                          label: s,
                          color: widget.category.color,
                          hovered: _hovered,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool hovered;

  const _SkillChip(
      {required this.label, required this.color, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: hovered ? color.withOpacity(0.15) : AppColors.cardBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: hovered ? color.withOpacity(0.4) : AppColors.borderLight,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: hovered ? color : AppColors.textSecondary,
        ),
      ),
    );
  }
}
