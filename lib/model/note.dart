final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id, title, description, time, userId
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static const String userId = 'userId';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;
  final int userId;


  const Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.userId,
});

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
    int? userId,
}) =>
  Note(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdTime: createdTime ?? this.createdTime,
    userId: userId ?? this.userId,
  );

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
    userId: json[NoteFields.userId] as int,
  );


  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.description: description,
    NoteFields.time: createdTime.toIso8601String(),
    NoteFields.userId: userId,
  };
}