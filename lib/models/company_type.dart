class CompanyType {
  final String id;
  final String name;

  CompanyType({required this.id, required this.name});

  factory CompanyType.fromJson(Map<String, dynamic> json) =>
      CompanyType(id: json['id'] as String, name: json['name'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class CompanyTypeList {
  CompanyTypeList({required this.list});

  factory CompanyTypeList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return CompanyType.fromJson(value as Map<String, dynamic>);
    }).toList();
    return CompanyTypeList(list: list);
  }

  final List<CompanyType> list;
}
