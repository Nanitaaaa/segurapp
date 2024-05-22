import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../services/firebase.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  TextEditingController clientController = TextEditingController(text: '' );
  TextEditingController fechaController = TextEditingController(text: '' );
  String tipo = 'robo';

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
            
            const Gap(10),

            //Crear DATEPICKER widget
            TextField( 
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Ingrese la fecha de la incidencia',
              ),
            ),
            
            const Gap(20),
        
            const Text('Seleccione el tipo de incidencia'),
            DropdownButton<String>(
              value: tipo,
              items: const [
                DropdownMenuItem(
                value: 'robo',
                child: Text('Robo'),
                ),
                DropdownMenuItem(
                  value: 'accidente',
                  child: Text('Accidente'),
                ),
                DropdownMenuItem(
                  value: 'disturbio',
                  child: Text('Disturbio'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  tipo = newValue!;
                });
              },
            ),

            const Gap(10),

            ElevatedButton(
              onPressed: () {
                createIncident(clientController.text, fechaController.text, tipo).then((_) => {
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