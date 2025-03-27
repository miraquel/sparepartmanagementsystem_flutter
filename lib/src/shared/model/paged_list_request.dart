class PagedListRequest {
  final int pageNumber;
  final int pageSize;
  final String sortBy;
  final bool isSortAscending;
  Map<String, String> filters;

  PagedListRequest({
    required this.pageNumber,
    required this.pageSize,
    required this.sortBy,
    required this.isSortAscending,
    required this.filters,
  });

  factory PagedListRequest.fromJson(Map<String, dynamic> json) => PagedListRequest(
    pageNumber: json['pageNumber'] as int? ?? 0,
    pageSize: json['pageSize'] as int? ?? 0,
    sortBy: json['sortBy'] ?? '',
    isSortAscending: json['isSortAscending'] ?? true,
    filters: json['filters'] as Map<String, String>? ?? {},
  );

  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'pageSize': pageSize,
    'sortBy': sortBy,
    'isSortAscending': isSortAscending,
    'filters': filters,
  };
}