class TableResponse {
  List<Tables> tables = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = Tables(id: key, name: value["name"], date: value["date"]);
      tables.add(table);
    });

    return tables;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final table = Tables(id: json['id'], name: json["name"], date: json["date"]);
    return table;
  }
}

class Tables {
  String id;
  String name;
  String date;

  Tables({
      required this.id,
      required this.name,
      required this.date,
  });
}