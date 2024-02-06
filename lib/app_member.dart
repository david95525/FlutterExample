import 'package:flutter/material.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bodytemperature/bodytemperature_page.dart';
import 'pages/member/member_page.dart';
import 'pages/bloodpressure/bloodpressure_page.dart';

class MemberApp extends StatefulWidget {
  const MemberApp({super.key});
  @override
  State<MemberApp> createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
//bottomNavigationBar
  int _bottomselectedIndex = 0;
  final _bodyList = [
    const MemberPage(),
    const BloodPressurePage(),
    const BodyTemperaturePage()
  ];
  final navigationitems = const [
    BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Member"),
    BottomNavigationBarItem(
        icon: Icon(Icons.bloodtype_sharp), label: "BloodPressure"),
    BottomNavigationBarItem(
        icon: Icon(Icons.thermostat), label: "BodyTemperature")
  ];
  void _onItemTap(int index) {
    setState(() => _bottomselectedIndex = index);
  }

//railNavigationBar
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabList.length,
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
              bottom: TabBar(
                tabs: tabList.map((choice) {
                  return Tab(
                    text: choice.title,
                    icon: Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: const Text('Jen'),
                    accountEmail: const Text('userGmail@gmail.com'),
                    currentAccountPicture: Image.asset('assets/waiting.gif'),
                    decoration: const BoxDecoration(color: Colors.deepOrange),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Item1'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.headset),
                    title: const Text('Item2'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Item3'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: navigationitems,
                onTap: _onItemTap,
                currentIndex: _bottomselectedIndex),
            body: Row(children: <Widget>[
              NavigationRail(
                selectedIndex: _bottomselectedIndex,
                groupAlignment: groupAlignment,
                onDestinationSelected: (int index) {
                  setState(() {
                    _bottomselectedIndex = index;
                  });
                },
                labelType: labelType,
                leading: showLeading
                    ? FloatingActionButton(
                        elevation: 0,
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        child: const Icon(Icons.add),
                      )
                    : const SizedBox(),
                trailing: showTrailing
                    ? IconButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
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
                  )
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(child: _bodyList[_bottomselectedIndex]),
            ])));
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
