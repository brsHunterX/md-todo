class Account {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;

  Account({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatar,
  });

  String get fullName => '$firstName $lastName';
  String get shortName => '${firstName[0]}${lastName[0]}'.toUpperCase();
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;
}