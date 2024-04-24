import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart'; // tambahkan ini jika belum ada
import 'package:film/db/film_db.dart';
import 'package:film/model/film.dart';
import 'package:film/widget/film_form.dart';

class EditFilmPage extends StatelessWidget {
  final String imageUrl = 'https://www.seeing-stars.com/Locations/Taken/TakenPoster.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Film'),
        actions: [buildButton()],
      ),
      body: Form(
        child: FilmFormWidget(
          isImportant: true,
          number: 5,
          title: 'Judul Film',
          description: 'Deskripsi Film',
          imageUrl: imageUrl,
          onChangedImportant: (value) {},
          onChangedNumber: (value) {},
          onChangedTitle: (value) {},
          onChangedDescription: (value) {},
        ),
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey.shade700,
        ),
        onPressed: () {},
        child: const Text('Save'),
      ),
    );
  }
}

class AddEditFilmPage extends StatefulWidget {
  final Film? film;

  const AddEditFilmPage({
    Key? key,
    this.film,
  }) : super(key: key);

  @override
  State<AddEditFilmPage> createState() => _AddEditFilmPageState();
}

class _AddEditFilmPageState extends State<AddEditFilmPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.film?.isImportant ?? false;
    number = widget.film?.number ?? 0;
    title = widget.film?.title ?? '';
    description = widget.film?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Film'),
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: FilmFormWidget(
          isImportant: isImportant,
          number: number,
          title: title,
          description: description,
          onChangedImportant: (isImportant) =>
              setState(() => this.isImportant = isImportant),
          onChangedNumber: (number) => setState(() => this.number = number),
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateFilm,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateFilm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.film != null;

      if (isUpdating) {
        await updateFilm();
      } else {
        await addFilm();
      }

      Navigator.of(context).pop();
    }
  }

  Future<void> updateFilm() async {
    final film = widget.film!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await FilmDatabase.instance.update(film);
  }

  Future<void> addFilm() async {
    final film = Film(
      title: title,
      isImportant: isImportant,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await FilmDatabase.instance.create(film);
  }
}