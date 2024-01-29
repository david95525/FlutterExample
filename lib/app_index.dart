import 'package:flutter/material.dart';
import 'package:flutter_example/my_router.dart';
import './login/login_page.dart';
import './home/home_page.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});
  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
//bottomNavigationBar
  final navigationitems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.login), label: "Login"),
  ];
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  final _bodyList = [
    const HomePage(title: "home"),
    const LoginPage(),
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.member),
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.firebase),
                    child: const Text('Firebase'))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: navigationitems,
                onTap: _onItemTap,
                currentIndex: _selectedIndex),
            body: _bodyList[_selectedIndex]));
  }
}
