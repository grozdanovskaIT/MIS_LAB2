import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';
import '../widgets/meal_grid_item.dart';
import 'recipe_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
    _searchController.addListener(_filterMeals);
  }

  Future<void> _loadMeals() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final meals = await _mealService.getMealsByCategory(widget.category);
      setState(() {
        _meals = meals;
        _filteredMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load meals: $e')),
        );
      }
    }
  }
  void _filterMeals() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _filteredMeals = _meals;
      });
    } else {
      try {
        final searchResults = await _mealService.searchMeals(query);
        setState(() {
          _filteredMeals = searchResults;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Search error: $e')),
          );
        }
      }
    }
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
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search meals...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredMeals.isEmpty
                    ? const Center(child: Text('No meals found'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: _filteredMeals.length,
                        itemBuilder: (context, index) {
                          return MealGridItem(
                            meal: _filteredMeals[index],
                            onTap: () async {
                              final recipe = await _mealService
                                  .getRecipeById(_filteredMeals[index].idMeal);
                              if (recipe != null && mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetailScreen(recipe: recipe),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

