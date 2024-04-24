import 'package:flutter/material.dart';

class FilmFormWidget extends StatelessWidget {
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final String imageUrl;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const FilmFormWidget({
    Key? key,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    this.imageUrl = '', // Provide a default value
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Important:'),
              Switch(
                value: isImportant,
                onChanged: onChangedImportant,
              ),
              Expanded(
                child: Slider(
                  value: number.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: number == 0
                      ? 'Not rated'
                      : number == 5
                      ? 'Excellent'
                      : number.toString(),
                  onChanged: (value) =>
                      onChangedNumber(value.toInt()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          buildImageInput(),
          const SizedBox(height: 8),
          buildTitleInput(),
          const SizedBox(height: 8),
          buildDescriptionInput(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildImageInput() => imageUrl.isNotEmpty
      ? Image.network(
    imageUrl,
    height: 200,
    width: double.infinity,
    fit: BoxFit.cover,
  )
      : const SizedBox.shrink();

  Widget buildTitleInput() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      labelText: 'Title',
      border: OutlineInputBorder(),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescriptionInput() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.black, fontSize: 18),
    decoration: const InputDecoration(
      labelText: 'Description',
      hintText: 'Type something...',
      border: OutlineInputBorder(),
    ),
    validator: (description) =>
    description != null && description.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );
}