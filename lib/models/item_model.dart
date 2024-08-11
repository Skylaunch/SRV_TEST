class ItemModel {
  final String? key;
  final String title;
  final String description;
  final String imagePath;

  ItemModel({
    this.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  ItemModel copyWith({
    String? key,
    String? title,
    String? description,
    String? imagePath,
  }) {
    return ItemModel(
      key: key ?? this.key,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.title == title &&
        other.description == description &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imagePath.hashCode;
  }
}
