class SigninStates {
  const SigninStates({this.email = "", this.password = ""});
  
  final String email;
  final String password;

  SigninStates copyWith({
    //optional name parameter
    String? email,
    String? password,
  }) {
    return SigninStates(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
