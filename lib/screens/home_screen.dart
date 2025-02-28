import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generation_app/bloc/image_bloc.dart';
import 'package:image_generation_app/bloc/image_state.dart';
import 'package:image_generation_app/bloc/image_event.dart';
import 'package:image_generation_app/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Generator')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter image prompt...',
              ),
              onSubmitted: (prompt) {
                context.read<ImageBloc>().add(GenerateImage(prompt));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is ImageLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (state is ImageError) {
                  return Center(child: Text(state.message));
                }
                
                if (state is ImageLoaded) {
                  return ListView.builder(
                    itemCount: state.images.length,
                    itemBuilder: (context, index) {
                      final image = state.images[index];
                      return ListTile(
                        leading: Image.network(
                          image.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(image.prompt),
                        subtitle: Text(
                          image.createdAt.toString(),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(image: image),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                
                return const Center(child: Text('No images yet'));
              },
            ),
          ),
        ],
      ),
    );
  }
}