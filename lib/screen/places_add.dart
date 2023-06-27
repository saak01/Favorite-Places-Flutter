import 'dart:io';

import 'package:favorite_places/provider/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/location_input.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({super.key});

  @override
  ConsumerState<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlace> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Title')),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add Place'),
              icon: const Icon(Icons.add),
            ),
          ]),
        ),
      ),
    );
  }
}
