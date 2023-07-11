interface class AuthSignUpDTO {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  AuthSignUpDTO({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toRemote() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
    };
  }
}