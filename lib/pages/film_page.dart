import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:film/db/film_db.dart';
import 'package:film/model/film.dart';
import 'package:film/pages/edit_film.dart';
import 'package:film/pages/film_detail.dart';
import 'package:film/widget/film_card.dart';

class FilmPages extends StatefulWidget {
  const FilmPages({Key? key}) : super(key: key);

  @override
  State<FilmPages> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPages> {
  late List<Film> films;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshFilms();
  }

  @override
  void dispose() {
    FilmDatabase.instance.close();
    super.dispose();
  }

  Future<void> refreshFilms() async {
    setState(() => isLoading = true);
    films = await FilmDatabase.instance.readAllFilms();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Films',
        style: TextStyle(fontSize: 24),
      ),
      actions: const [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : films.isEmpty
          ? const Text(
        'No Films',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildFilms(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.white,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditFilmPage()),
        );
        refreshFilms();
      },
    ),
  );

  Widget buildFilms() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: films.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final film = films[index];
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FilmDetailPage(filmId: film.id!),
          ));
          refreshFilms();
        },
        child: FilmCardWidget(film: film, index: index),
      );
    },
  );
}
