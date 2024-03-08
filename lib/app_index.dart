import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/bluetooth/bluetooth_page.dart';
import 'package:flutter_example/pages/local_storage/local_storage.dart';
import 'package:flutter_example/pages/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});
  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  String clientSecret = const String.fromEnvironment('client_secret');
  String clientId = const String.fromEnvironment('client_id');
  int _selectedIndex = 0;
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
                TextButton(onPressed: () => _get(), child: const Text('Get')),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.firebase),
                    child: const Text('Firebase')),
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

  void _get() async {
    final currentUri = html.window.location.href;
    final uri = Uri.parse(currentUri);
    final String? code = uri.queryParameters['code'];
    debugPrint('code: $code');
    Map<String, dynamic> data = {
      'code': code,
      'client_id': clientId,
      'client_secret': clientSecret,
      'redirect_uri': 'https://flutterexample.azurewebsites.net',
      'grant_type': 'authorization_code'
    };
    var client = http.Client();
    var response = await client.post(
        Uri.https('accountdev.microlifecloud.com', '/OAuth2/Token'),
        headers: {"Authorization": "application/json"},
        body: jsonEncode(data));
    if (response.statusCode == 200) {}
  }
}
