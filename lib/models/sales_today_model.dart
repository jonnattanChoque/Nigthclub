class SalesTodayResponse {
  List<SalesToday> tables = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = SalesToday(id: key, date: value["fecha"], total: value["total"]);
      tables.add(table);
    });

    return tables;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final table = SalesToday(id: "id", date: json["fecha"], total: json["total"]);
    return table;
  }
}

class SalesToday {
  String id;
  String date;
  String total;

  SalesToday({
      required this.id,
      required this.date,
      required this.total,
  });
}