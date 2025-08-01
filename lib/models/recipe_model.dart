class Recipe {
  final String title;
  final String image;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final String category;
  final int time; // Cooking time in minutes
  final double rating; // Rating out of 5

  Recipe({
    required this.title,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.time,
    required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      category: json['category'] as String,
      time: json['time'] as int,
      rating: json['rating'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'category': category,
      'time': time,
      'rating': rating,
    };
  }
}