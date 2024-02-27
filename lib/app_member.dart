import 'package:flutter/material.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/pages/bodytemperature/bodytemperature_page.dart';
import 'package:flutter_example/pages/widget_example/progressIndicator_page.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'pages/bloodpressure/bloodpressure_page.dart';

class MemberApp extends StatefulWidget {
  const MemberApp({super.key});
  @override
  State<MemberApp> createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CustomLocalizations localizations = CustomLocalizations();
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [
    const DashboardPage(),
    const BloodPressurePage(),
    const BodyTemperaturePage(),
  ];
  @override
  Widget build(BuildContext context) {
    Color? _backcolor = Colors.grey[100];
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.index),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await changeLanguage();
                  },
                ),
              ],
            ),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onItemTap,
                    labelType: NavigationRailLabelType.none,
                    minWidth: MediaQuery.of(context).size.width / 7,
                    backgroundColor: const Color.fromARGB(255, 29, 65, 133),
                    leading: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      alignment: Alignment.center,
                      child: Text(
                        "Company",
                        style: TextStyle(fontSize: 40, color: _backcolor),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.calculate,
                                size: MediaQuery.of(context).size.height / 10,
                                color: _backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: _backcolor),
                            child: Icon(Icons.calculate,
                                size: MediaQuery.of(context).size.height / 10,
                                color:const Color.fromARGB(255, 18, 20, 22))),
                        label: const Text('Member'),
                      ),
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.bloodtype_sharp,
                                size: MediaQuery.of(context).size.height / 10,
                                color: _backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: _backcolor),
                            child: Icon(Icons.bloodtype_sharp,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 29, 65, 133))),
                        label: const Text('BloodPressure'),
                      ),
                      NavigationRailDestination(
                        icon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            child: Icon(Icons.thermostat,
                                size: MediaQuery.of(context).size.height / 10,
                                color: _backcolor)),
                        selectedIcon: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100)),
                                color: _backcolor),
                            child: Icon(Icons.thermostat,
                                size: MediaQuery.of(context).size.height / 10,
                                color: const Color.fromARGB(255, 29, 65, 133))),
                        label: const Text('BodyTemperature'),
                      ),
                    ],
                  ),
                  Expanded(child: _bodyList[_selectedIndex]),
                ])));
  }

  Future<void> changeLanguage() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(CustomLocalizations.of(context)?.text("language") ??
                "language"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("en", "US"));
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("en_us") ??
                      "English"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  localizations.setLocale(context, const Locale("zh", "TW"));
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(CustomLocalizations.of(context)?.text("zh_tw") ??
                      "Chinese(Taiwan)"),
                ),
              ),
            ],
          );
        });
  }
}
