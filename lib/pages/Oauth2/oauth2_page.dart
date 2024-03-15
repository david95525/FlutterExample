import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

bool _initialUriIsHandled = false;

class Oauth2Page extends StatefulWidget {
  const Oauth2Page({super.key});
  @override
  State<Oauth2Page> createState() => _Oauth2PageState();
}

class _Oauth2PageState extends State<Oauth2Page> {
  StreamSubscription? _sub;
  Object? _err;
  String? _url;
  //dev
  String clientSecret = const String.fromEnvironment('client_secret');
  String clientId = const String.fromEnvironment('client_id');
  //display
  String code = "";
  String token = "";
  String saveToken = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _loadsaveToken();
    _handleInitialUri();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                TextButton(
                  onPressed: () => _devLogin(),
                  child: const Text('FlutterWebAuth'),
                ),
                TextButton(
                  onPressed: () => _browserLogin(),
                  child: const Text('urlLink'),
                ),
                TextButton(
                  onPressed: () => _gettoken(),
                  child: const Text('get_token'),
                )
              ],
            ),
            body: Column(children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () => _testAPI(),
                      child: const Text('TestAPI')),
                  TextButton(
                      onPressed: () => _TestCookie(),
                      child: const Text('TestCookie')),
                ],
              ),
              Text("code:$code"),
              Text("token:$token"),
              Text("save_token:$saveToken"),
              Text("$_url"),
              Text("$_err")
            ])));
  }

  void _testAPI() async {
    String url =
        Uri.https('flutterexample.azurewebsites.net', '/api/Account/GetCode', {
      'redirect_uri': 'my-research-flutterproject-com://',
    }).toString();
    final result = await FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: 'my-research-flutterproject-com');
    debugPrint(result);
    String? resultcode = Uri.parse(result).queryParameters['code'];
    setState(() {
      code = resultcode ?? "";
    });
  }

  void _TestCookie() async {
    String url = Uri.https(
        'flutterexample.azurewebsites.net', '/api/Account/TestCookie', {
      'redirect_uri': 'my-research-flutterproject-com://',
    }).toString();
    final result = await FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: 'my-research-flutterproject-com');
  }

  void _loadsaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      saveToken = prefs.getString('access_token') ?? "";
    });
  }

  void _devLogin() async {
    String url =
        Uri.https('accountdev.microlifecloud.com', '/OAuth2/Authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': 'my-research-flutterproject-com://',
      'state': 'flutter'
    }).toString();
    debugPrint(url);
    final result = await FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: 'my-research-flutterproject-com');
    debugPrint(result);
    String? resultcode = Uri.parse(result).queryParameters['code'];
    setState(() {
      code = resultcode ?? "";
    });
  }

  void _browserLogin() async {
    Uri url = Uri.https('accountdev.microlifecloud.com', '/OAuth2/Authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': 'my-research-flutterproject-com://',
      'state': 'flutter'
    });
    setState(() {
      _url = url.toString() ?? "";
    });
    await launchUrl(url, mode: LaunchMode.platformDefault);
  }

  void _gettoken() async {
    final response = await http.post(
        Uri.https('accountdev.microlifecloud.com', '/OAuth2/Token'),
        body: {
          'client_id': clientId,
          'redirect_uri': 'my-research-flutterproject-com://',
          'grant_type': 'authorization_code',
          'code': code,
          'client_secret': clientSecret
        });
    final accessToken = jsonDecode(response.body)['access_token'] as String;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (accessToken.isNotEmpty) {
        token = accessToken;
        prefs.setString('access_token', accessToken);
      }
    });
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          debugPrint('no initial uri');
        } else {
          debugPrint('got initial uri: $uri');
        }
        if (!mounted) return;
      } on PlatformException {
        debugPrint('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        debugPrint('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        debugPrint('got uri: $uri');
        String? resultcode = Uri.parse(uri.toString()).queryParameters['code'];
        setState(() {
          code = resultcode ?? "";
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        debugPrint('got err: $err');
        setState(() {
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }
}
