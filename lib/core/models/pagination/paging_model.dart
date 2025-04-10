import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_model.freezed.dart';
part 'paging_model.g.dart';

/// Model for pagination parameters
@freezed
class PagingModel with _$PagingModel {
  const factory PagingModel({
    /// Number of items to take per page
    @Default(10) int take,
    
    /// Page index (1-based)
    @Default(1) int index,
  }) = _PagingModel;

  factory PagingModel.fromJson(Map<String, dynamic> json) => _$PagingModelFromJson(json);
}

/// Model for pagination result
@freezed
class PaginatedResult<T> with _$PaginatedResult<T> {
  const factory PaginatedResult({
    /// List of items for the current page
    required List<T> items,
    
    /// Total number of items
    required int total,
    
    /// Current page index
    required int currentPage,
    
    /// Total number of pages
    required int totalPages,
    
    /// Number of items per page
    required int pageSize,
    
    /// Whether there is a next page
    required bool hasNext,
    
    /// Whether there is a previous page
    required bool hasPrevious,
  }) = _PaginatedResult;

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResult<T>(
      items: (json['items'] as List<dynamic>)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      pageSize: json['pageSize'] as int,
      hasNext: json['hasNext'] as bool,
      hasPrevious: json['hasPrevious'] as bool,
    );
  }
}
