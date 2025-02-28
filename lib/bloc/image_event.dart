abstract class ImageEvent {}

class LoadImages extends ImageEvent {}

class GenerateImage extends ImageEvent {
  final String prompt;
  
  GenerateImage(this.prompt);
}