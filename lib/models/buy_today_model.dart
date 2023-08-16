class BuysTodayResponse {
  List<BuysToday> tables = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final table = BuysToday(id: key, date: value["fecha"], total: value["total"]);
      tables.add(table);
    });

    return tables;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final table = BuysToday(id: "id", date: json["fecha"], total: json["total"]);
    return table;
  }
}

class BuysToday {
  String id;
  String date;
  String total;

  BuysToday({
      required this.id,
      required this.date,
      required this.total,
  });
}