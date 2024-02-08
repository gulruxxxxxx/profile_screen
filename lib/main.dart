import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:i_baza/core/database/objectbox.dart';
import 'package:i_baza/core/injector/set_up_locator.dart';
import 'package:i_baza/core/injector/storage_repository.dart';
import 'package:i_baza/features/authentication/data/models/authenticated_user.dart';
import 'package:i_baza/features/catalog/discount_page.dart';
import 'package:i_baza/features/pages/onboarding/onboarding_1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

import 'core/adapter/hive_type_adapter.dart';
import 'features/authentication/presentation/pages/profile_screen.dart';
import 'features/pages/splash_screen.dart';

Future<void> main() async {
  registerAdapters();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSingleton.getInstance();
  await Hive.initFlutter();
  var boxname = await Hive.openBox("name");
  var boxlocation = await Hive.openBox("location");
  var boxavatar = await Hive.openBox("avatar");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProfileScreen(
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? avatar;
  List<File> files = [];

  Future<void> pickAvatar() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        avatar = File.fromUri(Uri.file(file.path));
      });
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        files.addAll(
          result.files.map((file) => File.fromUri(Uri.file(file.path ?? ''))).toList(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of any text input field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Align(
              child: Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: avatar == null
                    ? Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.grey,
                )
                    : Image.file(
                  avatar!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              children: List.generate(
                files.length,
                    (index) => GestureDetector(
                  onTap: () async {
                    await OpenFile.open(files[index].path);
                  },
                  onLongPress: () async {
                    await Share.shareXFiles([XFile(files[index].path)]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      files[index].path.split(Platform.pathSeparator).last,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: pickAvatar,
              tooltip: 'Choose avatar',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: pickFile,
              tooltip: 'Choose file',
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
