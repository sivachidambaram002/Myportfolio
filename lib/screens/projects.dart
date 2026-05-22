// lib/widgets/sections/projects_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/portfolio_data.dart';
import '../core/theme.dart';
import '../models/skill_model.dart';
import '../utils/responsive.dart';
import '../widgets/common/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100)
          .add(Responsive.horizontalPadding(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.surface.withOpacity(0.3),
            AppColors.background,
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: 'Projects',
            title: 'Featured Projects',
            subtitle: 'Real production apps built and shipped to Play Store.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          if (isMobile || isTablet)
            Column(
              children: PortfolioData.projects
                  .asMap()
                  .entries
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FadeInUp(
                          delay: Duration(milliseconds: 100 * e.key),
                          child: _ProjectCard(project: e.value, index: e.key),
                        ),
                      ))
                  .toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: PortfolioData.projects
                  .asMap()
                  .entries
                  .map((e) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: e.key < PortfolioData.projects.length - 1
                                  ? 20
                                  : 0),
                          child: FadeInUp(
                            delay: Duration(milliseconds: 150 * e.key),
                            child: _ProjectCard(project: e.value, index: e.key),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  final List<List<Color>> _gradients = [
    [const Color(0xFF00D4FF), const Color(0xFF7B2FFF)],
    [const Color(0xFF7B2FFF), const Color(0xFF00FFB3)],
    [const Color(0xFFFF6B6B), const Color(0xFFFFD93D)],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _gradients[widget.index % _gradients.length];
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? colors[0].withOpacity(0.5) : AppColors.border,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _hovered
                ? [
                    colors[0].withOpacity(0.08),
                    colors[1].withOpacity(0.05),
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
                    color: colors[0].withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top banner
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge + icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.phone_android_rounded,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                      const Spacer(),
                      if (widget.project.status.contains('Live'))
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColors.success.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.success,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Live',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Text(
                            'Completed',
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.project.subtitle,
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: colors[0],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.project.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.description,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Features
                  ...widget.project.features.take(4).map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outline_rounded,
                                  size: 13, color: colors[0]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  f,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),
                  // Tech stack
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.techStack
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: colors[0].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: colors[0].withOpacity(0.25)),
                            ),
                            child: Text(
                              t,
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                color: colors[0],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  // Buttons
                  Row(
                    children: [
                      _ProjectBtn(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        onTap: () async {
                          final uri =
                              Uri.parse('https://github.com/sivachidambaram');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        color: colors[0],
                        outline: true,
                      ),
                      const SizedBox(width: 10),
                      _ProjectBtn(
                        label: 'Details',
                        icon: Icons.open_in_new_rounded,
                        onTap: () {},
                        color: colors[0],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool outline;

  const _ProjectBtn({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
    this.outline = false,
  });

  @override
  State<_ProjectBtn> createState() => _ProjectBtnState();
}

class _ProjectBtnState extends State<_ProjectBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.outline
                ? (_hovered
                    ? widget.color.withOpacity(0.15)
                    : Colors.transparent)
                : (_hovered ? widget.color : widget.color.withOpacity(0.85)),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.outline
                  ? (_hovered ? widget.color : AppColors.borderLight)
                  : widget.color,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 13,
                color: widget.outline
                    ? (_hovered ? widget.color : AppColors.textSecondary)
                    : Colors.black,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.outline
                      ? (_hovered ? widget.color : AppColors.textSecondary)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
