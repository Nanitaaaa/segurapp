import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../services/firebase.dart';


class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  TextEditingController clientController = TextEditingController(text: '' );
  TextEditingController fechaController = TextEditingController(text: '' );
  TextEditingController descController = TextEditingController(text: '' );
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
                labelText: 'Ingrese nombre del usuario',
              ),
            ),
             
            const Gap(10),

            TextField( 
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Describa la situación (opcional)',
              ),
            ),

            /*TextField( 
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Ingrese la fecha de la incidencia',
              ),
            ),*/
            
            const Gap(20),
        
            const Text('Seleccione el tipo de incidencia'),
            DropdownButton<String>(
              value: tipo,
              items: const [
                DropdownMenuItem(
                value: 'robo',
                child: Text('Robo / Asalto'),
                ),
                 DropdownMenuItem(
                value: 'extravio',
                child: Text('Extravío'),
                ),
                 DropdownMenuItem(
                value: 'violencia',
                child: Text('Violencia doméstica'),
                ),
                DropdownMenuItem(
                  value: 'accidente',
                  child: Text('Accidente de tránsito'),
                ),
                 DropdownMenuItem(
                value: 'sospecha',
                child: Text('Actividad sospechosa'),
                ),
                DropdownMenuItem(
                  value: 'disturbio',
                  child: Text('Disturbios'),
                ),
                 DropdownMenuItem(
                value: 'incendio',
                child: Text('Incendio'),
                ),
                 DropdownMenuItem(
                value: 'cortes',
                child: Text('Corte de tránsito'),
                ),
                 DropdownMenuItem(
                value: 'portonazo',
                child: Text('Portonazo'),
                ),
                 DropdownMenuItem(
                value: 'otro',
                child: Text('Otro..'),
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
                DateTime ahora = DateTime.now();
                String horaFormateada = DateFormat('dd/MM/yyyy kk:mm:ss').format(ahora);
                fechaController.text = horaFormateada;
                createIncident(clientController.text, fechaController.text, descController.text, tipo, 'Abierta').then((_) => {
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