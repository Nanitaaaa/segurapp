import 'package:flutter/material.dart';

import '../services/firebase.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  TextEditingController clientController = TextEditingController(text: '' );
  TextEditingController fechaController = TextEditingController(text: '' );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            TextField( 
              controller: clientController,
              decoration: const InputDecoration(
                labelText: 'Ingrese el nombre del cliente',
              ),
            ),
        
            TextField( 
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Ingrese la fecha de la incidencia',
              ),
            ),
        
            ElevatedButton(
              onPressed: () {
                createIncident(clientController.text, fechaController.text).then((_) => {
                  Navigator.pop(context),
                });
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}