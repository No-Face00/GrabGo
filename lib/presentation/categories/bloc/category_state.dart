


part of 'category_cubit.dart';

enum CategoryStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  const CategoryState._({
    this.status = CategoryStatus.initial,
    this.categories = const <Category>[],
    this.errorMessage,
  });

  const CategoryState.initial() : this._();

  final CategoryStatus status;
  final List<Category> categories;
  final String? errorMessage;

  CategoryState copyWith({
    CategoryStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return CategoryState._(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
