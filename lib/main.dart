import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staticnotes/Controller/note_Controller.dart';
import 'package:staticnotes/Veiw/Screens/HomeScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple Notes App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HomeScreen(),
    );
  }
}
