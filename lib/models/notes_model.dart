class NoteResponse {
  List<NotesValue> notes = [];

  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final category = NotesValue(id: key, details: value["details"], dates: value["dates"], title: value["title"]);
      notes.add(category);
    });

    return notes;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final category = NotesValue(
      id: json["id"], 
      details: json["details"], 
      title: json["title"], 
      dates: json["dates"]);
    return category;
  }
}

class NotesValue {
  String id;
  String details;
  String dates;
  String title;

  NotesValue({
      required this.id,
      required this.details,
      required this.dates,
      required this.title
  });
}