// lib/models/skill_model.dart

import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;
  final Color color;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
    required this.color,
  });
}

// lib/models/project_model.dart (included here)
class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final List<String> features;
  final String status;
  final String? playStoreUrl;
  final String? githubUrl;
  final String? demoUrl;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.features,
    required this.status,
    this.playStoreUrl,
    this.githubUrl,
    this.demoUrl,
  });
}

class EventModel {
  final String title;
  final String organizer;
  final String description;
  final String imagePath;

  const EventModel({
    required this.title,
    required this.organizer,
    required this.description,
    required this.imagePath,
  });
}
