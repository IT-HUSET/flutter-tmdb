import 'package:flutter/material.dart';

import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/main/main_scaffold.dart';
import 'package:tmdb/presentation/sign_in/sign_in.dart';

void main() => runApp(
      AppStateProvider(
        appState: AppState(),
        child: const MovieApp(),
      ),
    );

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'),
            displayMedium: TextStyle(
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'PlayfairDisplay'),
            displaySmall: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontFamily: 'PlayfairDisplay'),
            headlineLarge: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, fontFamily: 'Creepster'),
            headlineMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Creepster'),
          )),
      home: _AnimatedHomeContainer(),
    );
  }
}

class _AnimatedHomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = AppState.of(context);

    final size = MediaQuery.of(context).size;
    final constraints = BoxConstraints(maxHeight: size.height, maxWidth: size.width);

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 333),
      firstChild: ConstrainedBox(constraints: constraints, child: const SignInScreen()),
      secondChild: ConstrainedBox(constraints: constraints, child: MainScaffold(key: appState.mainScaffoldKey)),
      crossFadeState: appState.isLoggedIn ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
