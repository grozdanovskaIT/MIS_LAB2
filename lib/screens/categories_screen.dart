import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/meal_service.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';
import 'recipe_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final MealService _mealService = MealService();
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _searchController.addListener(_filterCategories);
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final categories = await _mealService.getCategories();
      final sortedCategories = _sortCategories(categories);
      setState(() {
        _categories = sortedCategories;
        _filteredCategories = sortedCategories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load categories: $e')),
        );
      }
    }
  }

  List<Category> _sortCategories(List<Category> categories) {
    final order = ['Breakfast', 'Salad', 'Starter', 'Side', 'Beef', 'Chicken', 'Lamb', 'Pork', 'Seafood', 'Pasta', 'Dessert'];
    
    final sorted = <Category>[];
    final remaining = List<Category>.from(categories);
    
    for (final categoryName in order) {
      final index = remaining.indexWhere((c) => c.strCategory == categoryName);
      if (index != -1) {
        sorted.add(remaining.removeAt(index));
      }
    }
    
    sorted.addAll(remaining);
    
    return sorted;
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        final filtered = _categories
            .where((category) =>
                category.strCategory.toLowerCase().contains(query) ||
                category.strCategoryDescription.toLowerCase().contains(query))
            .toList();
        _filteredCategories = _sortCategories(filtered);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE4E1),
        foregroundColor: const Color(0xFF8B4513),
        elevation: 0,
        title: const Text('Meal Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Random recipe',
            onPressed: () async {
              final recipe = await _mealService.getRandomRecipe();
              if (recipe != null && mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              } else if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Unable to load random recipe')),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFF8F0),
              const Color(0xFFFFF0F5),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredCategories.isEmpty
                      ? const Center(child: Text('No categories found'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _filteredCategories.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              category: _filteredCategories[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MealsScreen(
                                      category: _filteredCategories[index].strCategory,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

