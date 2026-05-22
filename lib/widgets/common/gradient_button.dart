// lib/widgets/common/gradient_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool outline;
  final double? width;

  const GradientButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.outline = false,
    this.width,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
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
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: widget.outline
                ? null
                : LinearGradient(
                    colors: _hovered
                        ? [
                            AppColors.secondary,
                            AppColors.primary,
                          ]
                        : [
                            AppColors.primary,
                            AppColors.secondary,
                          ],
                  ),
            border: widget.outline
                ? Border.all(
                    color: _hovered ? AppColors.primary : AppColors.borderLight,
                    width: 1.5,
                  )
                : null,
            boxShadow: !widget.outline && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 16,
                    color: widget.outline
                        ? (_hovered
                            ? AppColors.primary
                            : AppColors.textSecondary)
                        : Colors.black,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.outline
                        ? (_hovered
                            ? AppColors.primary
                            : AppColors.textSecondary)
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
