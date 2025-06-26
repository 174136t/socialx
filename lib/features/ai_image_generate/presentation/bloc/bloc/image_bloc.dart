import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialx/features/ai_image_generate/domain/usecases/generate_image.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GenerateImage generateImage;

  ImageBloc({required this.generateImage}) : super(ImageInitial()) {
    on<GenerateImageEvent>((event, emit) async {
      emit(ImageLoading());

      try {
        final generatedImage = await generateImage(event.prompt);
      } catch (e) {
        emit(ImageError(message: e.toString()));
      }
    });
  }
}
