import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:socialx/features/ai_image_generate/data/models/generated_image_model.dart';

abstract class ImageRemoteDataSource {
  Future<GeneratedImageModel> generateImage(String prompt);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final Dio dio;
  ImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<GeneratedImageModel> generateImage(String prompt) async {
    try {
      String url = "https://api.vyro.ai/v2/image/generations";
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-OAhAZ2Bj2sggiJCeDLbYFJBPbvM2cuD37B78VsiDCWo6bFc2t',
      };

      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style': 'imagine-turbo',
        'aspect_ratio': '1:1',
      };

      FormData formData = FormData.fromMap(payload);

      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes,
      );

      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200 && response.data != null) {
        // Assuming GeneratedImageModel has a factory constructor fromBytes
        return GeneratedImageModel.fromBytes(Uint8List.fromList(response.data!));
      } else {
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to generate image: $e');
    }
  }
}
