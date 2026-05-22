// lib/widgets/sections/footer_widget.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants.dart';
import '../core/theme.dart';
import '../utils/responsive.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 40)
          .add(Responsive.horizontalPadding(context)),
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: AppColors.border)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surface.withOpacity(0.4),
            AppColors.background,
          ],
        ),
      ),
      child: isMobile ? _MobileFooter() : _DesktopFooter(),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Logo
        ShaderMask(
          shaderCallback: (b) => AppColors.heroGradient.createShader(b),
          child: Text(
            AppConstants.name,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        // Social links
        _FooterLink(
          icon: Icons.code_rounded,
          label: 'GitHub',
          url: AppConstants.githubUrl,
        ),
        const SizedBox(width: 8),
        _FooterLink(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          url: AppConstants.linkedInUrl,
        ),
        const SizedBox(width: 8),
        _FooterLink(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          url: 'mailto:${AppConstants.email}',
        ),
        const SizedBox(width: 24),
        // Copyright
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '© ${DateTime.now().year} K. Sivachidambaram',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            _BuiltWithFlutter(),
          ],
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.heroGradient.createShader(b),
          child: Text(
            AppConstants.name,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(
              icon: Icons.code_rounded,
              label: 'GitHub',
              url: AppConstants.githubUrl,
            ),
            const SizedBox(width: 8),
            _FooterLink(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              url: AppConstants.linkedInUrl,
            ),
            const SizedBox(width: 8),
            _FooterLink(
              icon: Icons.mail_outline_rounded,
              label: 'Email',
              url: 'mailto:${AppConstants.email}',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© ${DateTime.now().year} K. Sivachidambaram',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        _BuiltWithFlutter(),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _FooterLink(
      {required this.icon, required this.label, required this.url});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 14,
                  color: _hovered ? AppColors.primary : AppColors.textMuted),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: _hovered ? AppColors.primary : AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuiltWithFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Built with ',
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: const Icon(Icons.flutter_dash, size: 14, color: Colors.white),
        ),
        Text(
          ' Flutter',
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
