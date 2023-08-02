class SalesResponse {
  List<Sales> tables = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = Sales(id: key, name: value["table"], date: value["created_at"], total: value["total"]);
      tables.add(table);
    });

    return tables;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final table = Sales(id: "id", name: json["table"], date: "null", total: json["total"]);
    return table;
  }
}

class Sales {
  String id;
  String name;
  String date;
  String total;

  Sales({
      required this.id,
      required this.name,
      required this.date,
      required this.total,
  });
}