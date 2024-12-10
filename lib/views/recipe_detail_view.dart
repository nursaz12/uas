import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import 'recipe_form_view.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({super.key, required this.recipe});

  Future<void> _deleteRecipe(BuildContext context) async {
    final url = 'http://192.168.61.104/recipe/crud/delete.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': recipe.id.toString(),
      },
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recipe deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete recipe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeFormView(recipe: recipe)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteRecipe(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bahan:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.ingredients),
            const SizedBox(height: 16),
            const Text('Instruksi:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.instructions),
            const SizedBox(height: 16),
            Text('Kategori: ${recipe.category}'),
          ],
        ),
      ),
    );
  }
}
