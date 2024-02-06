import 'package:flutter/material.dart';
import 'package:flutter_example/app_index.dart';
import 'package:flutter_example/app_member.dart';
import 'package:flutter_example/pages/firebase/firebase_login/firebase_login_page.dart';
import 'package:flutter_example/pages/local_storage/local_storage.dart';

class RouteName {
  static const String index = 'index';
  static const String member = 'member';
  static const String firebase = 'firebase';
  static const String localstorage = 'localstorage';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.index:
        return NoAnimRouteBuilder(const IndexApp());
      case RouteName.member:
        return NoAnimRouteBuilder(const MemberApp());
      case RouteName.firebase:
        return NoAnimRouteBuilder(const FirebaseLoginPage());
      case RouteName.localstorage:
        return NoAnimRouteBuilder(const LocalStorageApp());
      default:
        return NoAnimRouteBuilder(const IndexApp());
    }
  }
}

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}
