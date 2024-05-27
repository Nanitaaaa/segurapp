import 'package:flutter/material.dart';
import 'listadoincidencias.dart';
import 'registrarIncidencia.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Incidencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VistaPrincipal(),
    );
  }
}

class VistaPrincipal extends StatelessWidget {
  const VistaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrarIncidencia(),
                  ),
                );
              },
              child: const Text('Registrar Incidencia'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListaIncidencias(),
                  ),
                );
              },
              child: const Text('Ver Listado de Incidencias'),
            ),
          ],
        ),
      ),
    );
  }
}