import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_generation_app/bloc/image_bloc.dart';
import 'package:image_generation_app/repositories/image_repository.dart';
import 'package:image_generation_app/screens/home_screen.dart';
import 'package:image_generation_app/services/api_client.dart';
import 'package:image_generation_app/services/image_api.dart';
import 'package:image_generation_app/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize local storage
  final localStorage = LocalStorage();
  await localStorage.init();
  
  runApp(MyApp(storage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage storage;

  const MyApp({
    super.key,
    required this.storage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ImageBloc(
          imageRepository: ImageRepository(
            api: ImageApi(ApiClient()),
            storage: storage,
          ),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}