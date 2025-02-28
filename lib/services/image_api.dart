import 'package:image_generation_app/exceptions/api_exceptions.dart';
import 'package:image_generation_app/models/image_entry.dart';
import 'package:image_generation_app/services/api_client.dart';
import 'package:image_generation_app/services/api_constants.dart';

class ImageApi {
  final ApiClient _apiClient;

  ImageApi(this._apiClient);

  Future<ImageEntry> generateImage(String prompt) async {
    try {
      // Create prediction
      final createResponse = await _apiClient.post(
        ApiConstants.predictEndpoint,
        {
          'version': ApiConstants.modelVersion,
          'input': {
            'prompt': prompt,
            'negative_prompt': 'blurry, bad quality, worst quality',
            'num_inference_steps': 30,
          },
        },
      );

      final String predictionId = createResponse.data['id'];
      ImageEntry? result;
      
      // Poll for completion
      while (result == null) {
        final statusResponse = await _apiClient.get(
          '${ApiConstants.predictEndpoint}/$predictionId',
        );

        final status = statusResponse.data['status'];
        
        if (status == 'succeeded') {
          final output = statusResponse.data['output'] as List<dynamic>;
          result = ImageEntry(
            id: predictionId,
            prompt: prompt,
            imageUrl: output.first,
            createdAt: DateTime.now(),
          );
        } else if (status == 'failed') {
          throw ApiException(
            statusResponse.data['error'] ?? 'Image generation failed',
          );
        }

        if (result == null) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ImageEntry>> getImages() async {
    try {
      final response = await _apiClient.get(ApiConstants.predictEndpoint);
      
      return (response.data['results'] as List)
          .map((prediction) => ImageEntry(
                id: prediction['id'],
                prompt: prediction['input']['prompt'],
                imageUrl: prediction['output']?[0] ?? '',
                createdAt: DateTime.parse(prediction['created_at']),
              ))
          .where((entry) => entry.imageUrl.isNotEmpty)
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}