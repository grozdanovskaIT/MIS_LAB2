import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe.getIngredients();
    final youtubeUrl = recipe.strYoutube.trim();
    final formattedTags = recipe.strTags
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .join(', ');

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.strMeal),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.strMealThumb,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 56),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _PillChip(
                  icon: Icons.restaurant,
                  text: recipe.strCategory.isNotEmpty ? recipe.strCategory : 'Unknown',
                ),
                _PillChip(
                  icon: Icons.location_on,
                  text: recipe.strArea.isNotEmpty ? recipe.strArea : 'Unknown',
                ),
              ],
            ),
            if (youtubeUrl.isNotEmpty) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () => _openYoutube(context, youtubeUrl),
                  icon: const Icon(Icons.play_circle),
                  label: const Text('Watch on YouTube'),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (ingredients.isEmpty)
              const Text('No ingredients available for this recipe.')
            else
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      for (final ingredient in ingredients)
                        _BulletText(
                          text: _formatIngredientLine(
                            ingredient['ingredient'],
                            ingredient['measure'],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              recipe.strInstructions,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openYoutube(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open YouTube link')),
    );
  }
}

String _formatIngredientLine(String? name, String? measure) {
  final trimmedName = (name ?? '').trim();
  final trimmedMeasure = (measure ?? '').trim();
  if (trimmedMeasure.isEmpty) {
    return trimmedName;
  }
  return '$trimmedName - $trimmedMeasure';
}

class _PillChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PillChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: primary,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: primary,
                ),
          ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

