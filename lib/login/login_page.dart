import 'package:flutter/material.dart';
import 'login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';
import '../repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (BuildContext context) =>
            LoginBloc(userRepository: _userRepository),
        child: const LoginForm(),
      ),
    );
  }
}
