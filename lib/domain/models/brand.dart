import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  const Brand({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  });

  final int id;
  final String name;
  final String? imageUrl;
  final String? description;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: (json['id'] as num).toInt(),
      // API uses brandName and brandImg
      name: json['brandName'] as String? ?? json['name'] as String? ?? '',
      imageUrl: json['brandImg'] as String? ?? json['image'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'brandName': name,
    'brandImg': imageUrl,
    'description': description,
  };

  @override
  List<Object?> get props => [id, name, imageUrl, description];
}
