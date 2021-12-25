final String tableNotes = 'appointment';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, address, time
  ];

  static final String id = '_id';
  static final String address = 'address';

  static final String time = 'time';
}

class Note {
  final int? id;
  final String address;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.address,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? address,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,

        address: address ?? this.address,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        address: json[NoteFields.address] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.address: address,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
