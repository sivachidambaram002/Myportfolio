// lib/widgets/sections/hero_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import 'dart:math' as math;

import '../core/constants.dart';
import '../core/theme.dart';
import '../utils/responsive.dart';
import '../widgets/common/gradient_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _typeController;
  late Animation<double> _bgAnim;
  final List<String> _roles = [
    'Flutter Developer',
    'Mobile App Engineer',
    'Cross-Platform Expert',
    'Clean Architecture Dev',
  ];
  int _roleIndex = 0;
  String _displayedRole = '';
  bool _typing = true;
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _bgAnim = Tween<double>(begin: 0, end: 1).animate(_bgController);

    _typeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(_typeEffect);
    _typeController.repeat();
  }

  void _typeEffect() {
    if (!mounted) return;
    final currentRole = _roles[_roleIndex];
    if (_typing) {
      if (_charIndex < currentRole.length) {
        setState(() {
          _charIndex++;
          _displayedRole = currentRole.substring(0, _charIndex);
        });
        Future.delayed(const Duration(milliseconds: 80));
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _typing = false);
        });
        _typeController.stop();
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _typing = false;
            _startDeleting();
          }
        });
      }
    }
  }

  void _startDeleting() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return false;
      if (_charIndex > 0) {
        setState(() {
          _charIndex--;
          _displayedRole = _roles[_roleIndex].substring(0, _charIndex);
        });
        return true;
      } else {
        setState(() {
          _roleIndex = (_roleIndex + 1) % _roles.length;
          _typing = true;
          _charIndex = 0;
        });
        _typeController.repeat();
        return false;
      }
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    final anchor = html.AnchorElement(
      href: '/assets/pdf/resume.pdf',
    )
      ..target = 'blank'
      ..download = 'K_Sivachidambaram_Resume.pdf'
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenH = Responsive.screenHeight(context);

    return Container(
      constraints: BoxConstraints(minHeight: math.max(screenH, 700)),
      child: Stack(
        children: [
          // Animated background
          _AnimatedBackground(animation: _bgAnim),

          // Content
          Padding(
            padding: Responsive.horizontalPadding(context),
            child: isMobile
                ? _MobileHero(
                    displayedRole: _displayedRole,
                    onViewProjects: widget.onViewProjects,
                    onContact: widget.onContact,
                    onDownload: _downloadResume,
                  )
                : _DesktopHero(
                    displayedRole: _displayedRole,
                    isTablet: isTablet,
                    onViewProjects: widget.onViewProjects,
                    onContact: widget.onContact,
                    onDownload: _downloadResume,
                  ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeInUp(
              delay: const Duration(milliseconds: 1400),
              child: const _ScrollIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final String displayedRole;
  final bool isTablet;
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final Future<void> Function() onDownload;
  const _DesktopHero({
    required this.displayedRole,
    required this.isTablet,
    required this.onViewProjects,
    required this.onContact,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              FadeInLeft(
                duration: const Duration(milliseconds: 600),
                child: _AvailableBadge(),
              ),
              const SizedBox(height: 24),
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 700),
                child: Text(
                  'Hey, I\'m',
                  style: GoogleFonts.dmSans(
                    fontSize: isTablet ? 18 : 20,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInLeft(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 700),
                child: ShaderMask(
                  shaderCallback: (b) => AppColors.heroGradient.createShader(b),
                  child: Text(
                    AppConstants.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isTablet ? 44 : 62,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInLeft(
                delay: const Duration(milliseconds: 400),
                child: Row(
                  children: [
                    Text(
                      displayedRole,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: isTablet ? 22 : 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: isTablet ? 26 : 32,
                      color: AppColors.primary,
                      margin: const EdgeInsets.only(left: 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FadeInLeft(
                delay: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: 480,
                  child: Text(
                    '2 years building production-grade cross-platform apps for Android & iOS. '
                    'Live apps on Play Store. Passionate about clean code and seamless UX.',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.75,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInLeft(
                delay: const Duration(milliseconds: 550),
                child: _StatsRow(),
              ),
              const SizedBox(height: 36),
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    GradientButton(
                      label: 'View Projects',
                      icon: Icons.work_outline_rounded,
                      onTap: onViewProjects,
                    ),
                    GradientButton(
                      label: 'Download Resume',
                      icon: Icons.download_rounded,
                      onTap: () async {
                        await onDownload();
                      },
                      outline: true,
                    ),
                    GradientButton(
                      label: 'Contact Me',
                      icon: Icons.mail_outline_rounded,
                      onTap: onContact,
                      outline: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                delay: const Duration(milliseconds: 900),
                child: _SocialRow(),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: FadeInRight(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 800),
            child: _ProfileCard(),
          ),
        ),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final String displayedRole;
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final VoidCallback onDownload;

  const _MobileHero({
    required this.displayedRole,
    required this.onViewProjects,
    required this.onContact,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Center(child: FadeInDown(child: _ProfileCard(mobile: true))),
        const SizedBox(height: 32),
        FadeInLeft(child: _AvailableBadge()),
        const SizedBox(height: 16),
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Hey, I\'m',
            style: GoogleFonts.dmSans(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        FadeInLeft(
          delay: const Duration(milliseconds: 300),
          child: ShaderMask(
            shaderCallback: (b) => AppColors.heroGradient.createShader(b),
            child: Text(
              AppConstants.name,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeInLeft(
          delay: const Duration(milliseconds: 400),
          child: Row(
            children: [
              Text(
                displayedRole,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                width: 2,
                height: 22,
                color: AppColors.primary,
                margin: const EdgeInsets.only(left: 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FadeInLeft(
          delay: const Duration(milliseconds: 500),
          child: Text(
            '2 years building production cross-platform apps for Android & iOS. Live apps on Play Store.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInLeft(
            delay: const Duration(milliseconds: 550), child: _StatsRow()),
        const SizedBox(height: 28),
        FadeInUp(
          delay: const Duration(milliseconds: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GradientButton(
                label: 'View Projects',
                icon: Icons.work_outline_rounded,
                onTap: onViewProjects,
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              GradientButton(
                label: 'Download Resume',
                icon: Icons.download_rounded,
                onTap: onDownload,
                outline: true,
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              GradientButton(
                label: 'Contact Me',
                icon: Icons.mail_outline_rounded,
                onTap: onContact,
                outline: true,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        FadeInUp(delay: const Duration(milliseconds: 900), child: _SocialRow()),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  final Animation<double> animation;

  const _AnimatedBackground({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Stack(
          children: [
            // Gradient mesh background
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.6, -0.6),
                  radius: 1.2,
                  colors: [
                    Color(0x1500D4FF),
                    Color(0xFF080C14),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -100,
              top: -100,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color.lerp(
                        const Color(0x207B2FFF),
                        const Color(0x1500D4FF),
                        animation.value,
                      )!,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Grid pattern overlay
            CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: _GridPainter(),
            ),
          ],
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.04)
      ..strokeWidth = 0.5;
    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}

class _ProfileCard extends StatelessWidget {
  final bool mobile;
  const _ProfileCard({this.mobile = false});

  @override
  Widget build(BuildContext context) {
    final size = mobile ? 160.0 : 260.0;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow ring
          Container(
            width: size + 20,
            height: size + 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  AppColors.accent,
                  AppColors.primary,
                ],
              ),
            ),
          ),
          // Profile image or placeholder
          Container(
            width: size + 12,
            height: size + 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.surfaceElevated, AppColors.cardBg],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile2.png',
                fit: BoxFit.cover,
                errorBuilder: (ctx, _, __) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.surfaceElevated, AppColors.cardBg],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: size * 0.45,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SC',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: mobile ? 16 : 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Experience badge
          Positioned(
            bottom: mobile ? 8 : 16,
            right: mobile ? 8 : 16,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 10 : 14, vertical: mobile ? 6 : 10),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Text(
                '2 Yrs\nExp',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: mobile ? 11 : 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for opportunities',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        _StatItem(value: '2+', label: 'Years Exp'),
        _Divider(),
        _StatItem(value: '3+', label: 'Live Apps'),
        _Divider(),
        _StatItem(value: '35%', label: 'Perf Boost'),
        if (!isMobile) ...[
          _Divider(),
          _StatItem(value: '90%', label: 'Bug Reduce'),
        ],
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.border,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SocialIcon(
          icon: Icons.code_rounded,
          label: 'GitHub',
          url: AppConstants.githubUrl,
        ),
        const SizedBox(width: 12),
        _SocialIcon(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          url: AppConstants.linkedInUrl,
        ),
        const SizedBox(width: 12),
        _SocialIcon(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          url: 'mailto:${AppConstants.email}',
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialIcon(
      {required this.icon, required this.label, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withOpacity(0.12)
                : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withOpacity(0.4)
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 14,
                  color:
                      _hovered ? AppColors.primary : AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator();

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 8)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Column(
        children: [
          Transform.translate(
            offset: Offset(0, _anim.value),
            child: Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.primary.withOpacity(0.6), size: 28),
          ),
          Text(
            'Scroll to explore',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: AppColors.textMuted,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
