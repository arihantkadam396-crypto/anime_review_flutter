import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/anime_details_screen.dart';
import 'screens/add_review_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';
import 'models/anime.dart';

void main() {
  runApp(const AnimeReviewHub());
}

class AnimeReviewHub extends StatelessWidget {
  const AnimeReviewHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Review Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        FavoritesScreen.route: (_) => const FavoritesScreen(),
        ProfileScreen.route: (_) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AnimeDetailsScreen.route) {
          final anime = settings.arguments as Anime;
          return MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(anime: anime),
          );
        }
        if (settings.name == AddReviewScreen.route) {
          final anime = settings.arguments as Anime;
          return MaterialPageRoute(
            builder: (_) => AddReviewScreen(anime: anime),
          );
        }
        return null;
      },
      initialRoute: HomeScreen.route,
      debugShowCheckedModeBanner: false,
    );
  }
}
