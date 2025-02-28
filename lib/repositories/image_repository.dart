import 'package:image_generation_app/models/image_entry.dart';
import 'package:image_generation_app/services/image_api.dart';
import 'package:image_generation_app/storage/local_storage.dart';

class ImageRepository {
  final ImageApi api;
  final LocalStorage storage;

  ImageRepository({required this.api, required this.storage});

  Future<List<ImageEntry>> getImages() async {
    try {
      final images = await api.getImages();
      await storage.saveImages(images);
      return images;
    } catch (e) {
      return storage.getImages();
    }
  }

  Future<void> generateImage(String prompt) async {
    final image = await api.generateImage(prompt);
    await storage.saveImage(image);
  }
}