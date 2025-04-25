class ResponseModel<T> {
  final int currentPage;
  final List<T> items;
  final int pageSize;
  final int total;

  ResponseModel({
    required this.currentPage,
    required this.items,
    required this.pageSize,
    required this.total,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ResponseModel<T>(
      currentPage: json['current_page'] ?? 0,
      items: (json['items'] as List?)
              ?.map((item) => fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      pageSize: json['page_size'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJson) {
    return {
      'current_page': currentPage,
      'items': items.map((item) => toJson(item)).toList(),
      'page_size': pageSize,
      'total': total,
    };
  }
}
