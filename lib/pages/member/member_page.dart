import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/pages/firebase/bloc/app_bloc.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    String? email = user.email ?? "";
    String? username = user.name ?? "";
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "email: $email ",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "name: $username ",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ));
  }
}
