import 'package:flutter/material.dart';
import '../models/review.dart';
import 'rating_stars.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(review.user),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review.text),
          const SizedBox(height: 4),
          RatingStars(rating: review.rating),
        ],
      ),
      trailing: Text(
        '${review.createdAt.day}/${review.createdAt.month}/${review.createdAt.year}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
