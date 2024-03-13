import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bluetooth/bluetooth_page.dart';
import 'package:flutter_example/pages/local_storage/local_storage.dart';
import 'package:flutter_example/pages/login/login_page.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'pages/home/home_page.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});
  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  String clientSecret = const String.fromEnvironment('client_secret');
  String clientId = const String.fromEnvironment('client_id');
  int _selectedIndex = 0;
  String code = "";
  CustomLocalizations localizations = CustomLocalizations();
  final _bodyList = const [
    HomePage(),
    LoginPage(),
    LocalStorageApp(),
    BluetoothPage()
  ];
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
          icon: const Icon(Icons.storage),
          label: CustomLocalizations.of(context)?.text("Localstorage")),
      const BottomNavigationBarItem(
          icon: Icon(Icons.bluetooth), label: "Bluetooth"),
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
                IconButton(
                    tooltip: "Widgets",
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.widgets),
                    icon: const Icon(Icons.now_widgets_outlined),
                    selectedIcon: const Icon(Icons.now_widgets)),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.firebase),
                    child: const Text('Firebase')),
                IconButton(
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  onPressed: () => _oauth2Login(),
                ),
                Text(code)
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
                    title: Text(CustomLocalizations.of(context)?.text("EnUS") ??
                        "English"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(
                          context, const Locale("en", "US"));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(CustomLocalizations.of(context)?.text("ZhTW") ??
                        "Chinese(Taiwan)"),
                    onTap: () {
                      Navigator.pop(context);
                      localizations.setLocale(context, const Locale("zh"));
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
    if (index == 2) {
      Navigator.pushNamed(context, RouteName.localstorage);
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _oauth2Login() async {
    String url =
        Uri.https('flutterexample.azurewebsites.net', '/api/Account/GetCode', {
      // 'response_type': 'code',
      // 'client_id': clientId,
      'redirect_uri': 'my.research.flutterproject.com://',
      // 'state': 'flutter'
    }).toString();
    final result = await FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: 'my.research.flutterproject.com');
    String? result_code = Uri.parse(result).queryParameters['code'];
    setState(() {
      code = result_code ?? "";
    });
  }
}
