import 'package:flutter/material.dart';
import 'package:flutter_example/my_router.dart';
import './counter/counter_page.dart';
import 'bloodpressure/bloodpressure_page.dart';

class MemberApp extends StatefulWidget {
  const MemberApp({super.key});
  @override
  State<MemberApp> createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {
//bottomNavigationBar
  final navigationitems = const [
    BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Counter"),
    BottomNavigationBarItem(icon: Icon(Icons.bloodtype_sharp), label: "BloodPressure")
  ];
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [const CounterPage(), const BloodPressurePage()];
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
                currentIndex: _selectedIndex),
            body: _bodyList[_selectedIndex]));
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
