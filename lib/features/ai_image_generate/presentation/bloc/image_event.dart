part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class PromptInitialEvent extends ImageEvent {}

class GenerateImageEvent extends ImageEvent {
  final String prompt;
  GenerateImageEvent(this.prompt);
}
