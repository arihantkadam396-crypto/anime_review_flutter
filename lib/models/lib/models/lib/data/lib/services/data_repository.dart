import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/review.dart';

class DataRepository {
  static final DataRepository _instance = DataRepository._internal();
  factory DataRepository() => _instance;
  DataRepository._internal();

  // Keys
  static const _favKey = 'favorites'; // List<String> of animeIds
  static const _reviewsKeyPrefix = 'reviews_'; // per anime: reviews_<animeId>

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  // Favorites
  Future<List<String>> getFavorites() async {
    final p = await _prefs;
    return p.getStringList(_favKey) ?? <String>[];
  }

  Future<bool> isFavorite(String animeId) async {
    final favs = await getFavorites();
    return favs.contains(animeId);
  }

  Future<void> toggleFavorite(String animeId) async {
    final p = await _prefs;
    final current = p.getStringList(_favKey) ?? <String>[];
    if (current.contains(animeId)) {
      current.remove(animeId);
    } else {
      current.add(animeId);
    }
    await p.setStringList(_favKey, current);
  }

  // Reviews
  Future<List<Review>> getReviews(String animeId) async {
    final p = await _prefs;
    final raw = p.getString('$_reviewsKeyPrefix$animeId');
    if (raw == null) return [];
    final data = json.decode(raw) as List<dynamic>;
    return data.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> addReview(String animeId, Review review) async {
    final p = await _prefs;
    final current = await getReviews(animeId);
    current.add(review);
    final encoded = json.encode(current.map((e) => e.toJson()).toList());
    await p.setString('$_reviewsKeyPrefix$animeId', encoded);
  }
}
