import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:film/db/film_db.dart';
import 'package:film/model/film.dart';
import 'package:film/pages/edit_film.dart';

class FilmDetailPage extends StatefulWidget {
  final int filmId;

  const FilmDetailPage({
    Key? key,
    required this.filmId,
  }) : super(key: key);

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  late Film film;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    refreshFilm();
  }

  Future<void> refreshFilm() async {
    setState(() => isLoading = true);

    film = await FilmDatabase.instance.readFilm(widget.filmId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            film.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(film.createdTime),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            film.description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
    icon: const Icon(Icons.edit_outlined),
    onPressed: () async {
      if (isLoading) return;

      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditFilmPage(film: film),
      ));

      refreshFilm();
    },
  );

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await FilmDatabase.instance.delete(widget.filmId);

      Navigator.of(context).pop();
    },
  );
}
