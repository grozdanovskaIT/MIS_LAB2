import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/recipe.dart';

class MealService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['categories'] != null) {
          return (data['categories'] as List)
              .map((item) => Category.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/filter.php?c=${Uri.encodeComponent(category)}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null) {
          return (data['meals'] as List)
              .map((item) => Meal.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/search.php?s=${Uri.encodeComponent(query)}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null) {
          return (data['meals'] as List)
              .map((item) => Meal.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to search meals: $e');
    }
  }

  Future<Recipe?> getRecipeById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null && (data['meals'] as List).isNotEmpty) {
          return Recipe.fromJson(data['meals'][0]);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load recipe: $e');
    }
  }

  Future<Recipe?> getRandomRecipe() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null && (data['meals'] as List).isNotEmpty) {
          return Recipe.fromJson(data['meals'][0]);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load random recipe: $e');
    }
  }
}


