import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';

import 'package:http/http.dart' as http;

Future<String> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response we can get the body
    return response.body;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load');
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final userName = appState.currentUser?.username ?? 'n/a';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                  child: Column(children: [
                    Text('Logged in as:'.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
                    Text(userName, style: Theme.of(context).textTheme.headlineMedium),
                  ])),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
              onPressed: () {
                appState.logout();
              },
              child: const Text('Logout'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
