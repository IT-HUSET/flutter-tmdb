import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final AppState appState = AppState.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
        BottomNavigationBarItem(icon: _favoritesIcon(context, appState), label: 'Favorites'),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: onTap,
    );
  }

  Widget _favoritesIcon(BuildContext context, AppState appState) {
    if (appState.favoriteCount == 0) return const Icon(Icons.favorite);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Icon(Icons.favorite),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              '${appState.favoriteCount}',
              style: const TextStyle(fontSize: 9, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
