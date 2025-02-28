import 'package:flutter/material.dart';
import 'package:image_generation_app/models/image_entry.dart';
import 'package:intl/intl.dart';


class DetailScreen extends StatelessWidget {
  final ImageEntry image;
  
  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text('ID: ${image.id}'),
            const SizedBox(height: 8),
            Text('Prompt: ${image.prompt}'),
            const SizedBox(height: 8),
            Text(
              'Created: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(image.createdAt)}',
            ),
          ],
        ),
      ),
    );
  }
}