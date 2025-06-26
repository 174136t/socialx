part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageLoaded extends ImageState {
  final Uint8List imageBytes;
  ImageLoaded({required this.imageBytes});
}

final class ImageError extends ImageState {
  final String message;
  ImageError({required this.message});
}
