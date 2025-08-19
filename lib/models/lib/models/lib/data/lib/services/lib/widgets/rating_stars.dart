import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating; // 1..5
  final double size;
  const RatingStars({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating;
        return Icon(
          filled ? Icons.star : Icons.star_border,
          size: size,
        );
      }),
    );
  }
}
