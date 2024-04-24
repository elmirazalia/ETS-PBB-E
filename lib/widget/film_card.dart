import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:film/model/film.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({
    Key? key,
    required this.film,
    required this.index,
  }) : super(key: key);

  final Film film;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(film.createdTime);

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  film.isImportant ? Icons.star : Icons.star_border,
                  color: film.isImportant ? Colors.amber : Colors.grey,
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              film.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (film.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                film.description,
                style: TextStyle(color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
