import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';
import 'recipe_detail_view.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchRecipes();
  }

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse('http://192.168.61.104/recipe/crud/list.php'));

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      List jsonResponse = json.decode(response.body);
      print('Response data: $jsonResponse');
      return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      print('Failed to load recipes: ${response.statusCode}');
      throw Exception('Failed to load recipes');
    }
  }

  void _refreshRecipes() {
    setState(() {
      futureRecipes = fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Masakan'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(child: Text('Failed to load recipes'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: snapshot.data![index].image.isNotEmpty
                      ? Image.network(
                          'http://192.168.61.104/recipe/crud/${snapshot.data![index].image}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailView(recipe: snapshot.data![index]),
                      ),
                    ).then((_) => _refreshRecipes());
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No recipes found'));
          }
        },
      ),
    );
  }
}
