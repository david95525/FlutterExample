import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/login/login_page.dart';
import 'package:flutter_example/pages/weather/weather_page.dart';
import 'pages/home/home_page.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});
  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  int _selectedIndex = 0;
  CustomLocalizations localizations = CustomLocalizations();
  final _bodyList = const [HomePage(), LoginPage(), WeatherPage()];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navigationitems = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: CustomLocalizations.of(context)?.text("Home")),
      BottomNavigationBarItem(
          icon: const Icon(Icons.login),
          label: CustomLocalizations.of(context)?.text("Login")),
      BottomNavigationBarItem(
          icon: const Icon(Icons.sunny),
          label: CustomLocalizations.of(context)?.text("Weather")),
      BottomNavigationBarItem(
          icon: const Icon(Icons.storage),
          label: CustomLocalizations.of(context)?.text("Localstorage")),
    ];

    return DefaultTabController(
        length: 4,
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
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                      decoration: const BoxDecoration(color: Colors.deepOrange),
                      child: Text(
                        CustomLocalizations.of(context)?.text("language") ?? "",
                        style: const TextStyle(color: Colors.white),
                      )),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(
                        CustomLocalizations.of(context)?.text("en_us") ??
                            "English"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(
                          context, const Locale("en", "US"));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(
                        CustomLocalizations.of(context)?.text("zh_tw") ??
                            "Chinese(Taiwan)"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(
                          context, const Locale("zh", "TW"));
                    },
                  )
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

  void _onItemTap(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, RouteName.localstorage);
    } else {
      setState(() => _selectedIndex = index);
    }
  }
}
