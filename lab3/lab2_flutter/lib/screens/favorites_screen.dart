import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favoriteJokes;

  FavoritesScreen({required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Jokes"),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text("No favorite jokes yet!"))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(favoriteJokes[index]),
                  ),
                );
              },
            ),
    );
  }
}