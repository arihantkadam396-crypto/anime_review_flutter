import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../models/review.dart';
import '../services/data_repository.dart';
import '../widgets/review_tile.dart';
import '../widgets/rating_stars.dart';
import 'add_review_screen.dart';

class AnimeDetailsScreen extends StatefulWidget {
  static const route = '/details';
  final Anime anime;
  const AnimeDetailsScreen({super.key, required this.anime});

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  final repo = DataRepository();
  late Future<bool> _isFavFuture;
  late Future<List<Review>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _isFavFuture = repo.isFavorite(widget.anime.id);
    _reviewsFuture = repo.getReviews(widget.anime.id);
    setState(() {});
  }

  Future<void> _toggleFav() async {
    await repo.toggleFavorite(widget.anime.id);
    _load();
  }

  Future<void> _goAddReview() async {
    await Navigator.pushNamed(context, AddReviewScreen.route, arguments: widget.anime);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.anime;

    return Scaffold(
      appBar: AppBar(title: Text(a.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goAddReview,
        icon: const Icon(Icons.rate_review_outlined),
        label: const Text('Add Review'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(a.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 6),
                  Text(a.genre, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  Text(a.description),
                  const SizedBox(height: 16),
                  FutureBuilder<List<Review>>(
                    future: _reviewsFuture,
                    builder: (context, snap) {
                      final list = snap.data ?? [];
                      final avg = list.isEmpty
                          ? 0
                          : (list.map((e) => e.rating).reduce((a, b) => a + b) / list.length).round();
                      return Row(
                        children: [
                          const Text('Average Rating: '),
                          RatingStars(rating: avg),
                          Text(' (${list.length})'),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<bool>(
                    future: _isFavFuture,
                    builder: (context, snap) {
                      final fav = snap.data ?? false;
                      return FilledButton.icon(
                        onPressed: _toggleFav,
                        icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
                        label: Text(fav ? 'In Favorites' : 'Add to Favorites'),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Reviews', style: Theme.of(context).textTheme.titleLarge),
            ),
            FutureBuilder<List<Review>>(
              future: _reviewsFuture,
              builder: (context, snap) {
                final list = snap.data ?? [];
                if (list.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No reviews yet. Be the first to add one!'),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (_, i) => ReviewTile(review: list[i]),
                  separatorBuilder: (_, __) => const Divider(height: 0),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
