class Recipe {
  final int id;
  final String title;
  final String image;
  final String ingredients;
  final String instructions;
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      title: json['title'],
      image: json['image'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
      category: json['category'],
    );
  }
}
