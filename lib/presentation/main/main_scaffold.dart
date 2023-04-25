import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.body, required this.currentIndex});

  final Widget body;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final AppState appState = AppState.of(context);

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: _favoritesIcon(context, appState), label: 'Favorites'),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.of(context).pushReplacementNamed('movies');
          } else {
            Navigator.of(context).pushReplacementNamed('favorites');
          }
        },
      ),
    );
  }

  Widget _favoritesIcon(BuildContext context, AppState appState) {
    return Stack(alignment: Alignment.center,
        children: <Widget>[
          const Icon(Icons.favorite),
          Center(child:
            Padding(padding: const EdgeInsets.only(bottom: 2), child:
              Text('${appState.favoriteCount}', style: const TextStyle(fontSize: 9, color: Colors.white),),
            )
          ),
        ]
    );
  }
}
