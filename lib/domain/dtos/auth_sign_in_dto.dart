interface class AuthSignInDTO {
  final String email;
  final String password;

  AuthSignInDTO({ required this.email, required this.password });

  Map<String, dynamic> toRemote() {
    return {
      "email": email,
      "password": password,
    };
  }
}