import 'package:socialx/features/ai_image_generate/domain/entities/generated_image.dart';

import 'dart:typed_data';

class GeneratedImageModel extends GeneratedImage {
  GeneratedImageModel({required super.imageBytes});

  factory GeneratedImageModel.fromBytes(Uint8List bytes) {
    return GeneratedImageModel(imageBytes: bytes);
  }
}
