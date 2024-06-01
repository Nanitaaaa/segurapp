import 'package:flutter/material.dart';

//Importaciones para Firebase
import 'package:firebase_core/firebase_core.dart';


//Paginas de la aplicación
import 'firebase_options.dart';
import 'pages/create_page.dart';
import 'pages/experimental.dart';
import 'pages/home_page.dart';
import 'pages/update_page.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/create': (context) => const CreatePage(),
        '/update': (context) => const UpdatePage(),
        '/experimental': (context) => const ExperimentalPage(),
      },
    );
  }
}
