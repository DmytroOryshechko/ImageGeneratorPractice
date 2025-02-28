import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_generation_app/models/image_entry.dart';

class LocalStorage {
  static const String _boxName = 'images';
  late Box<ImageEntry> _box;

  Future<void> init() async {
    // Register the adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ImageEntryAdapter());
    }
    
    // Open the box
    _box = await Hive.openBox<ImageEntry>(_boxName);
  }

  Future<void> saveImage(ImageEntry image) async {
    await _box.put(image.id, image);
  }

  Future<void> saveImages(List<ImageEntry> images) async {
    final Map<String, ImageEntry> entries = {
      for (var image in images) image.id: image
    };
    await _box.putAll(entries);
  }

  List<ImageEntry> getImages() {
    return _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<ImageEntry?> getImage(String id) async {
    return _box.get(id);
  }
}