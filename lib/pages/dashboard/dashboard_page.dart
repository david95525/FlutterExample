import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/models/login/login_model.dart';
import 'package:flutter_example/models/response/response_model.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodglucose_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodpressure_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bodytemperature_board.dart';
import 'package:flutter_example/pages/dashboard/boards/oxygen_board.dart';
import 'package:flutter_example/pages/dashboard/boards/pain_board.dart';
import 'package:flutter_example/pages/dashboard/boards/user_board.dart';
import 'package:flutter_example/pages/login/bloc/login_bloc.dart';
import 'package:flutter_example/repository/user_repository.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late ResponseModel apidata;
  @override
  void initState() {
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(children: [
          const UserBoard(),
          const BodyTemperatureBoard(),
          const BloodpressureBoard(),
          const OxygenBoard(),
          const BloodglucoseBoard(),
          const PainBoard(),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () => debugPrint("save"),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 65, 133)),
              child: const Text('Save',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
            ),
          )
        ])
      ]),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login'),
            content: Column(children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email), labelText: 'Email'),
              ),
              TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock), labelText: 'Password'))
            ]),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Login'),
                onPressed: () => _login(),
              ),
            ],
          );
        });
  }

  void _onEmailChanged() {

  }

  void _onPasswordChanged() {

  }

  void _login() async {
    var client = http.Client();
    String email = _emailController.text;
    String password = _passwordController.text;
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
     
        } else {

        }
      }
    } finally {
      client.close();
    }
  }
}
