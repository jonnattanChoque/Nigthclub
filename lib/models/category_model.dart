class CategoryResponse {
  List<Category> categories = [];
  List<String> categoryNames = [];
  
  Future jsonDecodes(Map<String, dynamic> json) async {
    json.forEach((key, value) {
      final category = Category(id: key, name: value["name"], date: value["created_at"]);
      categories.add(category);
    });

    return categories;
  }

  Future jsonDecodeSingle(Map<String, dynamic> json) async {
    final category = Category(id: json['id'], name: json["name"], date: "null");
    return category;
  }

  jsonDecodeString(Map<String, dynamic> json) {
    json.forEach((key, value) {
      categoryNames.add(value["name"]);
    });
    var ascending = categoryNames..sort();
    return ascending;
  }
}

class Category {
  String id;
  String name;
  String date;

  Category({
      required this.id,
      required this.name,
      required this.date,
  });
}