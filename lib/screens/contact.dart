// lib/widgets/sections/contact_section.dart

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants.dart';
import '../core/theme.dart';
import '../services/contact_service.dart';
import '../utils/responsive.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/gradient_button.dart';
import '../widgets/common/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100)
          .add(Responsive.horizontalPadding(context)),
      child: Column(
        children: [
          const SectionTitle(
            label: 'Get In Touch',
            title: 'Contact Me',
            subtitle: 'Have a project or opportunity in mind? Let\'s talk.',
          ),
          SizedBox(height: isMobile ? 40 : 64),
          isMobile ? const _MobileContact() : const _DesktopContact(),
        ],
      ),
    );
  }
}

class _DesktopContact extends StatelessWidget {
  const _DesktopContact();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 700),
            child: const _ContactInfo(),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 5,
          child: FadeInRight(
            duration: const Duration(milliseconds: 700),
            child: const _ContactForm(),
          ),
        ),
      ],
    );
  }
}

class _MobileContact extends StatelessWidget {
  const _MobileContact();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ContactInfo(),
        SizedBox(height: 24),
        _ContactForm(),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Build\nSomething Great',
          style: GoogleFonts.spaceGrotesk(
            fontSize: Responsive.isMobile(context) ? 24 : 30,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m currently open to Flutter Developer roles in Chennai, Bangalore, and remote/international opportunities. Reach out directly or use the form.',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        _ContactItem(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          value: AppConstants.email,
          onTap: () async {
            final uri = Uri.parse('mailto:${AppConstants.email}');
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: AppConstants.phone,
          onTap: () async {
            final uri = Uri.parse('tel:${AppConstants.phone}');
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: AppConstants.location,
          onTap: null,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _SocialBtn(
              icon: Icons.code_rounded,
              label: 'GitHub',
              url: AppConstants.githubUrl,
            ),
            const SizedBox(width: 12),
            _SocialBtn(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              url: AppConstants.linkedInUrl,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.primary.withOpacity(0.15)
                    : AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _hovered
                      ? AppColors.primary.withOpacity(0.4)
                      : AppColors.border,
                ),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  widget.value,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _hovered ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialBtn(
      {required this.icon, required this.label, required this.url});

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 15,
                  color:
                      _hovered ? AppColors.primary : AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
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

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final success = await ContactService.sendMessage(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      message: _msgCtrl.text.trim(),
    );
    setState(() => _loading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success
                  ? Icons.check_circle_rounded
                  : Icons.error_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              success
                  ? 'Message sent! I\'ll reply soon.'
                  : 'Failed to send. Please try emailing directly.',
              style: GoogleFonts.dmSans(fontSize: 13),
            ),
          ],
        ),
        backgroundColor: success ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
    if (success) {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _msgCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHover: false,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'I usually respond within 24 hours.',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 24),
            _FormField(
              controller: _nameCtrl,
              label: 'Full Name',
              hint: 'John Smith',
              icon: Icons.person_outline_rounded,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter your name'
                  : null,
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _emailCtrl,
              label: 'Email Address',
              hint: 'john@company.com',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Please enter your email';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _msgCtrl,
              label: 'Message',
              hint: 'Hi Siva, I have an exciting Flutter opportunity...',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (v) => v == null || v.trim().length < 10
                  ? 'Message must be at least 10 characters'
                  : null,
            ),
            const SizedBox(height: 24),
            GradientButton(
              label: _loading ? 'Sending...' : 'Send Message',
              icon: _loading ? null : Icons.send_rounded,
              onTap: _loading ? null : _submit,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.dmSans(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
      ),
      validator: validator,
    );
  }
}
