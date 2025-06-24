import 'package:socialx/features/ai_image_generate/domain/entities/generated_image.dart';

abstract class ImageRepository {
  Future<GeneratedImage> generateImage(String prompt);
}
