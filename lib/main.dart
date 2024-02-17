import 'package:firebase_authentication_repository/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/localizations.dart';
import 'package:flutter_example/pages/firebase/bloc/app_bloc.dart';
import 'package:flutter_example/pages/firebase/bloc/bloc_observer.dart';
import 'package:flutter_example/firebase_options.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseAuthenticationRepository = FirebaseAuthenticationRepository();
  await firebaseAuthenticationRepository.user.first;
  runApp(MyApp(
      firebaseAuthenticationRepository: firebaseAuthenticationRepository));
}

class MyApp extends StatefulWidget {
  const MyApp({
    required FirebaseAuthenticationRepository firebaseAuthenticationRepository,
    super.key,
  }) : _firebaseAuthenticationRepository = firebaseAuthenticationRepository;

  final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;
  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("zh", "TW");
  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: widget._firebaseAuthenticationRepository,
        child: BlocProvider(
            create: (_) => AppBloc(
                  authenticationRepository:
                      widget._firebaseAuthenticationRepository,
                ),
            child: MaterialApp(
              title: 'flutter_example',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: MyRouter.generateRoute,
              initialRoute: RouteName.index,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
              ),
              localizationsDelegates: const [
                CustomLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('zh', 'TW'),
              ],
              locale: _locale,
            )));
  }
}
