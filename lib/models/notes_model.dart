class NoteResponse {
  List<NotesValue> notes = [];

  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final category = NotesValue(id: key, details: value["details"], date: value["created_at"]);
      notes.add(category);
    });

    return notes;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final category = NotesValue(id: json['id'], details: json["details"], date: "null");
    return category;
  }
}

class NotesValue {
  String id;
  String details;
  String date;

  NotesValue({
      required this.id,
      required this.details,
      required this.date,
  });
}