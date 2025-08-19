import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile / About')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Anime Review Hub', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('A Flutter app demonstrating navigation, forms, lists, state management, and local storage using SharedPreferences.'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Browse anime list'),
            Text('• View details & average rating'),
            Text('• Add reviews with validation'),
            Text('• Favorites with persistence'),
          ],
        ),
      ),
    );
  }
}
