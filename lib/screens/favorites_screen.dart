import 'package:flutter/material.dart';
import '../data/sample_anime.dart';
import '../services/data_repository.dart';
import '../widgets/anime_card.dart';

class FavoritesScreen extends StatefulWidget {
  static const route = '/favorites';
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final repo = DataRepository();
  late Future<List<String>> _favIds;

  @override
  void initState() {
    super.initState();
    _favIds = repo.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: FutureBuilder<List<String>>(
        future: _favIds,
        builder: (context, snap) {
          final favIds = snap.data ?? [];
          final favAnime = sampleAnime.where((a) => favIds.contains(a.id)).toList();
          if (favAnime.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }
          return ListView.builder(
            itemCount: favAnime.length,
            itemBuilder: (_, i) => AnimeCard(anime: favAnime[i]),
          );
        },
      ),
    );
  }
}
