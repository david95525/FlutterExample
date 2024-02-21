import 'package:flutter/material.dart';
import 'package:flutter_example/pages/dashboard/userboard.dart';

class DahboardPage extends StatefulWidget {
  const DahboardPage({super.key});

  @override
  State<DahboardPage> createState() => _DahboardPageState();
}

class _DahboardPageState extends State<DahboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [UserBoard(context)]);
  }
}
