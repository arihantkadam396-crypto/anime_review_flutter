import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../models/review.dart';
import '../services/data_repository.dart';

class AddReviewScreen extends StatefulWidget {
  static const route = '/add-review';
  final Anime anime;
  const AddReviewScreen({super.key, required this.anime});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _textCtrl = TextEditingController();
  int _rating = 3;
  final repo = DataRepository();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final review = Review(user: _nameCtrl.text.trim(), text: _textCtrl.text.trim(), rating: _rating);
      await repo.addReview(widget.anime.id, review);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review • ${widget.anime.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Your name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _textCtrl,
                decoration: const InputDecoration(labelText: 'Your review'),
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a review' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Rating: '),
                  Expanded(
                    child: Slider(
                      value: _rating.toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: '$_rating',
                      onChanged: (v) => setState(() => _rating = v.toInt()),
                    ),
                  ),
                  Text('$_rating/5'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send),
                  label: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
