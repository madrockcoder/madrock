class BusinessCategory {
  final String categoryId;
  final String categoryName;
  final String subCategoryId;
  final String subCategoryName;

  BusinessCategory({
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  factory BusinessCategory.fromJson(Map<String, dynamic> json) =>
      BusinessCategory(
        categoryId: json['business_category']['id'] as String,
        categoryName: json['business_category']['name'] as String,
        subCategoryId: json['sub_category_id'] as String,
        subCategoryName: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'category_name': categoryName,
        'sub_category_id': subCategoryId,
        'sub_category_name': subCategoryName,
      };
}

class BusinessCategoryList {
  BusinessCategoryList({required this.list});

  factory BusinessCategoryList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BusinessCategory.fromJson(value as Map<String, dynamic>);
    }).toList();
    return BusinessCategoryList(list: list);
  }

  final List<BusinessCategory> list;
}
