import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/pages/firebase/bloc/app_bloc.dart';

class DahboardPage extends StatefulWidget {
  const DahboardPage({super.key});

  @override
  State<DahboardPage> createState() => _DahboardPageState();
}

class _DahboardPageState extends State<DahboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.02),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 200, 245, 253)),
          child: Icon(Icons.people,
              size: MediaQuery.of(context).size.height / 8,
              color: const Color.fromARGB(255, 29, 65, 133)))
    ]);
  }
}
