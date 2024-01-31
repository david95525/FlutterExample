import 'package:firebase_authentication_repository/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/firebase/bloc/app_bloc.dart';
import 'package:flutter_example/firebase/bloc/bloc_observer.dart';
import 'package:flutter_example/firebase_options.dart';
import 'package:flutter_example/my_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseAuthenticationRepository = FirebaseAuthenticationRepository();
  await firebaseAuthenticationRepository.user.first;
  runApp(MyApp(
      firebaseAuthenticationRepository: firebaseAuthenticationRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required FirebaseAuthenticationRepository firebaseAuthenticationRepository,
    super.key,
  }) : _firebaseAuthenticationRepository = firebaseAuthenticationRepository;

  final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _firebaseAuthenticationRepository,
        child: BlocProvider(
            create: (_) => AppBloc(
                  authenticationRepository: _firebaseAuthenticationRepository,
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
            )));
  }
}
