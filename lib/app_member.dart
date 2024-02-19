import 'package:flutter/material.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bodytemperature/bodytemperature_page.dart';
import 'package:flutter_example/pages/widget_example/layout_page.dart';
import 'package:flutter_example/pages/widget_example/progressIndicator_page.dart';
import 'package:flutter_example/pages/widget_example/input_page.dart';
import 'package:flutter_example/pages/widget_example/listview_page.dart';
import 'pages/member/member_page.dart';
import 'pages/bloodpressure/bloodpressure_page.dart';

class MemberApp extends StatefulWidget {
  const MemberApp({super.key});
  @override
  State<MemberApp> createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [
    const MemberPage(),
    const BloodPressurePage(),
    const BodyTemperaturePage(),
    const ProgressPage()
  ];
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              leading: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    if (scaffoldKey.currentState!.isDrawerOpen) {
                      scaffoldKey.currentState!.closeDrawer();
                    } else {
                      scaffoldKey.currentState!.openDrawer();
                    }
                  }),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.index),
                )
              ],
              title: _selectedIndex > 2
                  ? const TabBar(
                      tabs: [
                        Tab(text: 'ProgressIndicator'),
                        Tab(text: 'Input'),
                        Tab(text: 'Layout'),
                        Tab(text: 'ListView'),
                      ],
                    )
                  : null,
            ),
            body: Row(children: <Widget>[
              NavigationRail(
                selectedIndex: _selectedIndex,
                groupAlignment: groupAlignment,
                onDestinationSelected: _onItemTap,
                labelType: labelType,
                leading: showLeading
                    ? FloatingActionButton(
                        elevation: 0,
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      )
                    : const SizedBox(),
                trailing: showTrailing
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_rounded),
                      )
                    : const SizedBox(),
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.calculate),
                    selectedIcon: Icon(Icons.calculate),
                    label: Text('Member'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bloodtype_sharp),
                    selectedIcon: Icon(Icons.bloodtype_sharp),
                    label: Text('BloodPressure'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.thermostat),
                    selectedIcon: Icon(Icons.thermostat),
                    label: Text('BodyTemperature'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.now_widgets_outlined),
                    selectedIcon: Icon(Icons.now_widgets),
                    label: Text('widgets'),
                  )
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(
                  child: _selectedIndex <= 2
                      ? _bodyList[_selectedIndex]
                      : const TabBarView(
                          children: [
                            ProgressPage(),
                            InputPage(),
                            LayoutPage(),
                            ListViewPage()
                          ],
                        )),
            ])));
  }
}
