import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generation_app/repositories/image_repository.dart';
import 'package:image_generation_app/bloc/image_event.dart';
import 'package:image_generation_app/bloc/image_state.dart';


class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;

  ImageBloc({required this.imageRepository}) : super(ImageInitial()) {
    on<LoadImages>((event, emit) async {
      try {
        final images = await imageRepository.getImages();
        emit(ImageLoaded(images));
      } catch (e) {
        emit(ImageError(e.toString()));
      }
    });

    on<GenerateImage>((event, emit) async {
      emit(ImageLoading());
      try {
        await imageRepository.generateImage(event.prompt);
        final images = await imageRepository.getImages();
        emit(ImageLoaded(images));
      } catch (e) {
        emit(ImageError(e.toString()));
      }
    });
  }
}