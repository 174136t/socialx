part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageLoaded extends ImageState {
  final File image;
  ImageLoaded({required this.image});
}

final class ImageError extends ImageState {
  final String message;
  ImageError({required this.message});
}
