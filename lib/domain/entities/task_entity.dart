class Task {
  final String id;
  final String createdAt;
  final String title;
  final String body;
  final String? completedAt;

  Task({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    this.completedAt,
  });
}