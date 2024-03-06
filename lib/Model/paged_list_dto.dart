class PagedListDto<T> {
  final List<T>? items;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  PagedListDto({
    this.items,
    this.pageNumber = 0,
    this.pageSize = 0,
    this.totalPages = 0,
    this.totalCount = 0,
    this.hasPreviousPage = false,
    this.hasNextPage = false
  });

  factory PagedListDto.fromJson(Map<String, dynamic> json, Function(dynamic) create) => PagedListDto<T>(
    items: create(json['items']),
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    totalPages: json['totalPages'] as int,
    totalCount: json['totalCount'] as int,
    hasPreviousPage: json['hasPreviousPage'] as bool,
    hasNextPage: json['hasNextPage'] as bool
  );

  Map<String, dynamic> toJson() => {
    'items': items,
    'pageNumber': pageNumber,
    'pageSize': pageSize,
    'totalPages': totalPages,
    'totalCount': totalCount,
    'hasPreviousPage': hasPreviousPage,
    'hasNextPage': hasNextPage
  };
}
