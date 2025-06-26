import 'package:socialx/features/ai_image_generate/domain/entities/generated_image.dart';
import 'package:socialx/features/ai_image_generate/domain/repositories/image_repository.dart';

class GenerateImage {
  final ImageRepository repositiry;
  GenerateImage(this.repositiry);

  Future<GeneratedImage> call(String prompt) {
    return repositiry.generateImage(prompt);
  }
}
