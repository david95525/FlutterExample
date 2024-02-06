import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/pages/login/bloc/login_bloc.dart';
import 'package:flutter_example/models/login/login_model.dart';
import 'package:flutter_example/models/response/response_model.dart';
import 'package:flutter_example/my_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bloc/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  late ResponseModel apidata;
  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Login Failure'),
                Icon(Icons.error),
              ],
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state.isSuccess) {
          String username = apidata.data?.name ?? "";
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Login success , Member $username'),
                const Icon(Icons.error)
              ],
            ),
            backgroundColor: Colors.green,
          ));
          Timer(const Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pushNamed(context, RouteName.member);
          });
        }
      },
      builder: (BuildContext context, LoginState state) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      'assets/back.jpg',
                      height: 200,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email), labelText: 'Email'),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (value) {
                      if (value.toString().isEmpty) return null;
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Password'),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (value) {
                      if (value.toString().isEmpty) return null;
                      return !Validators.isValidPassword(value.toString())
                          ? 'Invalid Password'
                          : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            if (state.isFormValid &&
                                _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              _onFormSubmitted();
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _login(_emailController.text, _passwordController.text);
  }

  void _login(String email, String password) async {
    var client = http.Client();
    try {
      final data = LoginModel(email: email, password: password);
      var response = await client.post(
          Uri.https('flutterexample.azurewebsites.net', '/api/Account/Login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      if (response.statusCode == 200) {
        setState(() {
          apidata = ResponseModel.fromJson(jsonDecode(response.body));
        });
        if (apidata.code == 10000) {
          _loginBloc.add(const LoginWithPassword(isSuceess: true));
        } else {
          _loginBloc.add(const LoginWithPassword(isSuceess: false));
        }
      }
    } finally {
      client.close();
    }
  }
}
