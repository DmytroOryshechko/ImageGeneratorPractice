import 'package:hive/hive.dart';

part 'image_entry.g.dart';

@HiveType(typeId: 0)
class ImageEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String prompt;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final DateTime createdAt;

  ImageEntry({
    required this.id,
    required this.prompt,
    required this.imageUrl,
    required this.createdAt,
  });

  // Add a copyWith method for convenient modifications
  ImageEntry copyWith({
    String? id,
    String? prompt,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return ImageEntry(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}