class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int userId; // <<< CAMPO ADICIONADO

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.userId, // <<< CAMPO ADICIONADO
  });

  Note copyWith({int? id}) => Note(
    id: id ?? this.id,
    title: title,
    content: content,
    createdAt: createdAt,
    userId: userId,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'userId': userId, // <<< CAMPO ADICIONADO
  };

  static Note fromMap(Map<String, Object?> map) => Note(
    id: map['id'] as int?,
    title: map['title'] as String,
    content: map['content'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String),
    userId: map['userId'] as int, // <<< CAMPO ADICIONADO
  );
}