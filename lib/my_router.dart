import 'package:flutter/material.dart';
import 'package:flutter_example/app_index.dart';
import 'package:flutter_example/app_member.dart';

class RouteName {
  static const String index = 'index';
  static const String member = 'member';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.index:
        return NoAnimRouteBuilder(const AppIndex());
      case RouteName.member:
        return NoAnimRouteBuilder(const AppMember());
      default:
        return NoAnimRouteBuilder(const AppIndex());
    }
  }
}

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}
