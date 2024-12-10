import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/recipe.dart';

class RecipeFormView extends StatefulWidget {
  final Recipe? recipe;
  const RecipeFormView({super.key, this.recipe});

  @override
  _RecipeFormViewState createState() => _RecipeFormViewState();
}

class _RecipeFormViewState extends State<RecipeFormView> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _ingredients;
  late String _instructions;
  late String _category;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _title = widget.recipe?.title ?? '';
    _ingredients = widget.recipe?.ingredients ?? '';
    _instructions = widget.recipe?.instructions ?? '';
    _category = widget.recipe?.category ?? '';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Title: $_title');
      print('Ingredients: $_ingredients');
      print('Instructions: $_instructions');
      print('Category: $_category');

      if (_imageFile == null) {
        print('File gambar tidak dipilih');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gambar harus dipilih')),
        );
        return;
      }

      Recipe recipe = Recipe(
        id: widget.recipe?.id ?? 0,
        title: _title,
        ingredients: _ingredients,
        instructions: _instructions,
        category: _category, 
        image: _imageFile!.path,
      );

      var uri = Uri.parse(widget.recipe == null
          ? 'http://192.168.61.104/recipe/crud/create.php'
          : 'http://192.168.61.104/recipe/crud/update.php');

      var request = http.MultipartRequest('POST', uri);
      request.fields['title'] = recipe.title;
      request.fields['ingredients'] = recipe.ingredients;
      request.fields['instructions'] = recipe.instructions;
      request.fields['category'] = recipe.category;
      if (recipe.id != 0) {
        request.fields['id'] = recipe.id.toString();
      }

      request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      print('Sending request to $uri');
      var response = await request.send();
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonResponse = json.decode(responseData.body);
        print('Response data: $jsonResponse');
        if (jsonResponse['message'] == 'Data input successfully' || jsonResponse['message'] == 'Data updated successfully') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Recipe saved successfully')),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save recipe')),
          );
        }
      } else {
        print('Failed to communicate with server');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to communicate with server')),
        );
      }
    } else {
      print('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Judul Resep'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Judul tidak boleh kosong');
                    return 'Judul harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _ingredients,
                decoration: InputDecoration(labelText: 'Bahan-bahan'),
                onSaved: (value) => _ingredients = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Bahan-bahan tidak boleh kosong');
                    return 'Bahan-bahan harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _instructions,
                decoration: InputDecoration(labelText: 'Instruksi'),
                onSaved: (value) => _instructions = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Instruksi tidak boleh kosong');
                    return 'Instruksi harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Kategori'),
                onSaved: (value) => _category = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    print('Kategori tidak boleh kosong');
                    return 'Kategori harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pilih Gambar'),
              ),
              if (_imageFile != null) Image.file(_imageFile!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text(widget.recipe == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
