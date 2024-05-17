import 'package:flutter/material.dart';

//Importaciones para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:segurapp/services/firebase.dart';
import 'firebase_options.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getIncidents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Center
              (child:Text(snapshot.data?[index]['cliente'] ?? ''));
            }
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })
      );
    }
  }