class TableResponse {
  List<Tables> tables = [];
  List<String> tableNames = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = Tables(id: key, name: value["name"], date: value["created_at"]);
      tables.add(table);
    });

    return tables;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final table = Tables(id: json['id'], name: json["name"], date: "nullclear");
    return table;
  }

  jsonDecodeString(Map<String, dynamic> json) {
    json.forEach((key, value) {
      tableNames.add(value["name"]);
    });
    var ascending = tableNames..sort();
    return ascending;
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