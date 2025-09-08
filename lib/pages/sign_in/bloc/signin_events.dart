abstract class SignInEvents {
  const SignInEvents();
}

class EmailEvent extends SignInEvents {
  final String email;
  const EmailEvent(this.email);
}
class PassWordEvent extends SignInEvents {
  final String password;
  const PassWordEvent(this.password);
}
