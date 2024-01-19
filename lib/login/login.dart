import 'package:flutter/material.dart';
import 'login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (BuildContext context) => LoginBloc(),
        child: const LoginForm(),
      ),
    );
  }
}
