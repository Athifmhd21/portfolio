class ProjectModel {
  const ProjectModel({
    required this.name,
    required this.type,
    required this.role,
    required this.client,
    required this.description,
    required this.purpose,
    required this.features,
    required this.previews,
  });

  final String name;
  final String type;
  final String role;
  final String client;
  final String description;
  final String purpose;
  final String features;
  final List<ProjectPreview> previews;
}

class ProjectPreview {
  const ProjectPreview({
    required this.image,
    required this.heading,
    required this.description,
    required this.highlight,
  });

  final String image;
  final String heading;
  final String description;
  final String highlight;
}
