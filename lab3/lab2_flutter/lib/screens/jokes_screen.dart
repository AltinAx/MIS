import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';

class JokesScreen extends StatefulWidget {
  final String type;

  const JokesScreen({super.key, required this.type});

  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  List<Joke> jokes = [];
  List<Joke> favoriteJokes = []; // List to store favorite jokes
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    try {
      jokes = await ApiService.getJokesByType(widget.type);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleFavorite(Joke joke) {
    setState(() {
      if (favoriteJokes.contains(joke)) {
        favoriteJokes.remove(joke);
      } else {
        favoriteJokes.add(joke);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          favoriteJokes.contains(joke)
              ? "Added to favorites!"
              : "Removed from favorites!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type.toUpperCase()} Jokes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoriteJokes: favoriteJokes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFavorite = favoriteJokes.contains(joke);
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      toggleFavorite(joke);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;

  const FavoritesScreen({super.key, required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Jokes")),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text("No favorite jokes yet!"))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(favoriteJokes[index].setup),
                    subtitle: Text(favoriteJokes[index].punchline),
                  ),
                );
              },
            ),
    );
  }
}