interface class TaskCreateDTO {
  final String title;
  final String body;

  TaskCreateDTO({ required this.title, required this.body });

  Map<String, dynamic> toRemote() {
    return {
      "title": title,
      "body": body,
    };
  }
}