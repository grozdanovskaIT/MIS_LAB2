class Recipe {
  final String idMeal;
  final String strMeal;
  final String strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  final String strIngredient1;
  final String strIngredient2;
  final String strIngredient3;
  final String strIngredient4;
  final String strIngredient5;
  final String strIngredient6;
  final String strIngredient7;
  final String strIngredient8;
  final String strIngredient9;
  final String strIngredient10;
  final String strIngredient11;
  final String strIngredient12;
  final String strIngredient13;
  final String strIngredient14;
  final String strIngredient15;
  final String strIngredient16;
  final String strIngredient17;
  final String strIngredient18;
  final String strIngredient19;
  final String strIngredient20;
  final String strMeasure1;
  final String strMeasure2;
  final String strMeasure3;
  final String strMeasure4;
  final String strMeasure5;
  final String strMeasure6;
  final String strMeasure7;
  final String strMeasure8;
  final String strMeasure9;
  final String strMeasure10;
  final String strMeasure11;
  final String strMeasure12;
  final String strMeasure13;
  final String strMeasure14;
  final String strMeasure15;
  final String strMeasure16;
  final String strMeasure17;
  final String strMeasure18;
  final String strMeasure19;
  final String strMeasure20;

  Recipe({
    required this.idMeal,
    required this.strMeal,
    required this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.strIngredient1,
    required this.strIngredient2,
    required this.strIngredient3,
    required this.strIngredient4,
    required this.strIngredient5,
    required this.strIngredient6,
    required this.strIngredient7,
    required this.strIngredient8,
    required this.strIngredient9,
    required this.strIngredient10,
    required this.strIngredient11,
    required this.strIngredient12,
    required this.strIngredient13,
    required this.strIngredient14,
    required this.strIngredient15,
    required this.strIngredient16,
    required this.strIngredient17,
    required this.strIngredient18,
    required this.strIngredient19,
    required this.strIngredient20,
    required this.strMeasure1,
    required this.strMeasure2,
    required this.strMeasure3,
    required this.strMeasure4,
    required this.strMeasure5,
    required this.strMeasure6,
    required this.strMeasure7,
    required this.strMeasure8,
    required this.strMeasure9,
    required this.strMeasure10,
    required this.strMeasure11,
    required this.strMeasure12,
    required this.strMeasure13,
    required this.strMeasure14,
    required this.strMeasure15,
    required this.strMeasure16,
    required this.strMeasure17,
    required this.strMeasure18,
    required this.strMeasure19,
    required this.strMeasure20,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strDrinkAlternate: json['strDrinkAlternate'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strTags: json['strTags'] ?? '',
      strYoutube: json['strYoutube'] ?? '',
      strIngredient1: json['strIngredient1'] ?? '',
      strIngredient2: json['strIngredient2'] ?? '',
      strIngredient3: json['strIngredient3'] ?? '',
      strIngredient4: json['strIngredient4'] ?? '',
      strIngredient5: json['strIngredient5'] ?? '',
      strIngredient6: json['strIngredient6'] ?? '',
      strIngredient7: json['strIngredient7'] ?? '',
      strIngredient8: json['strIngredient8'] ?? '',
      strIngredient9: json['strIngredient9'] ?? '',
      strIngredient10: json['strIngredient10'] ?? '',
      strIngredient11: json['strIngredient11'] ?? '',
      strIngredient12: json['strIngredient12'] ?? '',
      strIngredient13: json['strIngredient13'] ?? '',
      strIngredient14: json['strIngredient14'] ?? '',
      strIngredient15: json['strIngredient15'] ?? '',
      strIngredient16: json['strIngredient16'] ?? '',
      strIngredient17: json['strIngredient17'] ?? '',
      strIngredient18: json['strIngredient18'] ?? '',
      strIngredient19: json['strIngredient19'] ?? '',
      strIngredient20: json['strIngredient20'] ?? '',
      strMeasure1: json['strMeasure1'] ?? '',
      strMeasure2: json['strMeasure2'] ?? '',
      strMeasure3: json['strMeasure3'] ?? '',
      strMeasure4: json['strMeasure4'] ?? '',
      strMeasure5: json['strMeasure5'] ?? '',
      strMeasure6: json['strMeasure6'] ?? '',
      strMeasure7: json['strMeasure7'] ?? '',
      strMeasure8: json['strMeasure8'] ?? '',
      strMeasure9: json['strMeasure9'] ?? '',
      strMeasure10: json['strMeasure10'] ?? '',
      strMeasure11: json['strMeasure11'] ?? '',
      strMeasure12: json['strMeasure12'] ?? '',
      strMeasure13: json['strMeasure13'] ?? '',
      strMeasure14: json['strMeasure14'] ?? '',
      strMeasure15: json['strMeasure15'] ?? '',
      strMeasure16: json['strMeasure16'] ?? '',
      strMeasure17: json['strMeasure17'] ?? '',
      strMeasure18: json['strMeasure18'] ?? '',
      strMeasure19: json['strMeasure19'] ?? '',
      strMeasure20: json['strMeasure20'] ?? '',
    );
  }

  List<Map<String, String>> getIngredients() {
    List<Map<String, String>> ingredients = [];
    List<String> ingredientFields = [
      strIngredient1,
      strIngredient2,
      strIngredient3,
      strIngredient4,
      strIngredient5,
      strIngredient6,
      strIngredient7,
      strIngredient8,
      strIngredient9,
      strIngredient10,
      strIngredient11,
      strIngredient12,
      strIngredient13,
      strIngredient14,
      strIngredient15,
      strIngredient16,
      strIngredient17,
      strIngredient18,
      strIngredient19,
      strIngredient20,
    ];
    List<String> measureFields = [
      strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15,
      strMeasure16,
      strMeasure17,
      strMeasure18,
      strMeasure19,
      strMeasure20,
    ];

    for (int i = 0; i < ingredientFields.length; i++) {
      if (ingredientFields[i].isNotEmpty) {
        ingredients.add({
          'ingredient': ingredientFields[i],
          'measure': measureFields[i].isNotEmpty ? measureFields[i] : '',
        });
      }
    }
    return ingredients;
  }
}

