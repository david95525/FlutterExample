import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool _switchSelected = true;
  bool? _checkboxSelected = true;
  final TextEditingController _inputfieldController = TextEditingController();
  //form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _inputfieldController.addListener(_inputfieldChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: _inputfieldController,
          decoration: const InputDecoration(
            labelText: "inputfield",
            hintText: "inputfield",
            prefixIcon: Icon(Icons.person),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        Switch(
          value: _switchSelected,
          onChanged: (value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red,
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
        Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "email_form",
                  hintText: " your email",
                  icon: Icon(Icons.person),
                ),
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "please fill in";
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "password_form",
                  hintText: "your passwoed",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v) {
                  return v!.trim().length > 5
                      ? null
                      : "password must be at least 6 characters";
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("login in"),
                        ),
                        onPressed: () {
                          if ((_formKey.currentState as FormState).validate()) {
                            debugPrint("success");
                          }
                        },
                      ),
                    )
                  ]))
            ])),
      ],
    );
  }

  void _inputfieldChanged() {
    debugPrint(_inputfieldController.text);
  }
}
