import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            key: scaffoldKey,
            body: Center(
                child: Text(
                    CustomLocalizations.of(context)?.text('home_title') ??
                        ''))));
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
