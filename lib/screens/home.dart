// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:portfolio/screens/projects.dart';
import 'package:portfolio/screens/resume.dart';
import 'package:portfolio/screens/skills.dart';
import '../../widgets/navbar/navbar.dart';
import 'about.dart';
import 'contact.dart';
import 'events.dart';
import 'experience.dart';
import 'footer.dart';
import 'herosection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for navigation
  final List<GlobalKey> _sectionKeys = List.generate(8, (_) => GlobalKey());

  // Indexes match navItems order:
  // 0=home, 1=about, 2=skills, 3=experience, 4=projects, 5=events, 6=resume, 7=contact

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero (section 0)
                KeyedSubtree(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onViewProjects: () => _scrollToSection(4),
                    onContact: () => _scrollToSection(7),
                  ),
                ),
                // About (section 1)
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),
                // Skills (section 2)
                KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
                // Experience (section 3)
                KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ExperienceSection(),
                ),
                // Projects (section 4)
                KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ProjectsSection(),
                ),
                // Events (section 5)
                KeyedSubtree(
                  key: _sectionKeys[5],
                  child: const EventsSection(),
                ),
                // Resume (section 6)
                KeyedSubtree(
                  key: _sectionKeys[6],
                  child: const ResumeSection(),
                ),
                // Contact (section 7)
                KeyedSubtree(
                  key: _sectionKeys[7],
                  child: const ContactSection(),
                ),
                // Footer
                const FooterWidget(),
              ],
            ),
          ),
          // Sticky Navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
