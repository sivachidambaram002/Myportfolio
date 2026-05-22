// lib/widgets/navbar/navbar.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants.dart';
import '../../core/theme.dart';
import '../../utils/responsive.dart';

class PortfolioNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const PortfolioNavbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  bool _scrolled = false;
  int _activeIndex = 0;
  bool _mobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 20;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
    _updateActiveSection();
  }

  void _updateActiveSection() {
    for (int i = widget.sectionKeys.length - 1; i >= 0; i--) {
      final ctx = widget.sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 120) {
        if (_activeIndex != i) setState(() => _activeIndex = i);
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
    if (_mobileMenuOpen) setState(() => _mobileMenuOpen = false);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.surface.withOpacity(0.92)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.border : Colors.transparent,
          ),
        ),
        boxShadow: _scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                ),
              ]
            : [],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: Responsive.horizontalPadding(context),
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                // Logo
                ShaderMask(
                  shaderCallback: (b) => AppColors.heroGradient.createShader(b),
                  child: Text(
                    isMobile ? 'SC' : 'Sivachidambaram',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isMobile ? 20 : 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                if (isMobile) ...[
                  IconButton(
                    onPressed: () =>
                        setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        _mobileMenuOpen ? Icons.close : Icons.menu,
                        key: ValueKey(_mobileMenuOpen),
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ] else ...[
                  ...List.generate(
                    AppConstants.navItems.length,
                    (i) => _NavItem(
                      label: AppConstants.navItems[i],
                      active: _activeIndex == i,
                      onTap: () => _scrollToSection(i),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _HireButton(
                    onTap: () => _scrollToSection(
                      AppConstants.navItems.indexOf('Contact'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
                  color: widget.active || _hovered
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.active ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HireButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HireButton({required this.onTap});

  @override
  State<_HireButton> createState() => _HireButtonState();
}

class _HireButtonState extends State<_HireButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [AppColors.secondary, AppColors.primary])
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            'Hire Me',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
