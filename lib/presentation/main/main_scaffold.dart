import 'package:flutter/material.dart';

import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/main/main_bottom_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<StatefulWidget> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  /// MaterialApp builds a HeroController by default for the root Navigator, but since we're using a nested Navigator,
  /// we need to build a HeroController for that on our own.
  final _heroController = MaterialApp.createMaterialHeroController();

  String _initialLocation(int index) {
    switch (index) {
      case 1: return 'favorites';
      case 2: return 'settings';
      default: return 'movies';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      body: _navigator(context, appState),
      bottomNavigationBar: MainBottomBar(
        currentIndex: appState.mainSectionIndex,
        onTap: (index) => appState.mainSectionIndex = index,
      ),
    );
  }

  Widget _navigator(BuildContext context, AppState appState) {
    final appRouter = appState.appRouter;

    /// Define a scope for hero transitions - needs to be done for each Navigator.
    return HeroControllerScope(
      controller: _heroController,
      child: Navigator(
        key: ValueKey('Navigator-section-${appState.mainSectionIndex}'),
        initialRoute: _initialLocation(appState.mainSectionIndex),
        onGenerateRoute: (settings) {
          final String name = settings.name ?? '';
          return MaterialPageRoute(settings: settings, builder: appRouter.routes[name]!);
        },
      ),
    );
  }
}
