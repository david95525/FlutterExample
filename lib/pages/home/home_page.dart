import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
            key: scaffoldKey, body: const Center(child: Text('Home Page'))));
  }
}

class TabChoice {
  final String title;
  final IconData icon;
  const TabChoice(this.title, this.icon);
}

const List<TabChoice> tabList = <TabChoice>[
  TabChoice('Happy', Icons.mood),
  TabChoice('Sad', Icons.mood_bad),
];
