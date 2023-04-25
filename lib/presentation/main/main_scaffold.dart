import 'package:flutter/material.dart';

import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/main/main_bottom_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<StatefulWidget> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  /// MaterialApp builds a HeroController by default for the root Navigator, but since we build navigators on our own,
  /// we need to build a HeroController for each Navigator.
  final _heroController = List.generate(3, (_) => MaterialApp.createMaterialHeroController());

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _navigator(context, appState, 'movies', 0),
          _navigator(context, appState, 'favorites', 1),
          _navigator(context, appState, 'settings', 2),
        ],
      ),
      bottomNavigationBar: MainBottomBar(
        currentIndex: appState.mainSectionIndex,
        onTap: (index) => appState.mainSectionIndex = index,
      ),
    );
  }

  Widget _navigator(BuildContext context, AppState appState, String initialRoute, int index) {
    final appRouter = appState.appRouter;

    /// Define a scope for hero transitions - needs to be done for each Navigator.
    return HeroControllerScope(
      controller: _heroController[index],

      /// We use Offstage to hide the Navigator that is not currently active.
      child: Offstage(
        offstage: index != appState.mainSectionIndex,
        child: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            final String name = settings.name ?? '';
            return MaterialPageRoute(settings: settings, builder: appRouter.routes[name]!);
          },
        ),
      ),
    );
  }
}
