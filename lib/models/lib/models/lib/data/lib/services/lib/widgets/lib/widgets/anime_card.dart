import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../screens/anime_details_screen.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(
          context,
          AnimeDetailsScreen.route,
          arguments: anime,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  anime.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(anime.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(anime.genre),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
