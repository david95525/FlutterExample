part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

//Email改變
class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

//密碼改變
class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [password];
}

//使用信箱密碼登入
class LoginWithPassword extends LoginEvent {
  final String email;
  final String password;

  const LoginWithPassword({required this.email, required this.password});

  @override
  String toString() {
    return 'Login { email: $email, password: $password }';
  }

  @override
  List<Object> get props => [email, password];
}
