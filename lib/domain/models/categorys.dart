import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.imageUrl
  });

  final int id;
  final String name;
  final String? imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: (json['id'] as num).toInt(),
      name: json['categoryName'] as String? ?? json['name'] as String? ?? '',
      imageUrl: json['categoryImg'] as String? ?? json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': name,
    'categoryImg': imageUrl,
  };

  @override
  List<Object?> get props => [id, name, imageUrl];
}
