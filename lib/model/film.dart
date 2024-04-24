const String tableFilm = 'film';

class FilmFields {
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';

  static const List<String> values = [id, isImportant, number, title, description, time];
}

class Film {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Film({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Film copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Film(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Film fromJson(Map<String, Object?> json) => Film(
    id: json[FilmFields.id] as int?,
    isImportant: (json[FilmFields.isImportant] ?? 0) == 1,
    number: json[FilmFields.number] as int,
    title: json[FilmFields.title] as String,
    description: json[FilmFields.description] as String,
    createdTime: DateTime.parse(json[FilmFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    FilmFields.id: id,
    FilmFields.title: title,
    FilmFields.isImportant: isImportant ? 1 : 0,
    FilmFields.number: number,
    FilmFields.description: description,
    FilmFields.time: createdTime.toIso8601String(),
  };
}