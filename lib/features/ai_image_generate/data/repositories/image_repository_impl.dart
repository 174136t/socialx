import 'package:socialx/features/ai_image_generate/data/datasources/image_remote_data_source.dart';
import 'package:socialx/features/ai_image_generate/domain/entities/generated_image.dart';
import 'package:socialx/features/ai_image_generate/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  ImageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<GeneratedImage> generateImage(String prompt) {
    return remoteDataSource.generateImage(prompt);
  }
}
