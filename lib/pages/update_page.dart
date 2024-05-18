import 'package:flutter/material.dart';

import '../services/firebase.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  TextEditingController clientController = TextEditingController(text: '' );
  TextEditingController fechaController = TextEditingController(text: '' );

  @override
  Widget build(BuildContext context) {
    //Acceder a los argumentos pasados por el ModalRoute
    final arguments = ModalRoute.of(context)!.settings.arguments as Set<dynamic>;
    final List<dynamic> argumentsList = arguments.toList();
    //Dentro de la lista, se obtienen los datos del cliente y la fecha en las posiciones 0 y 1, respectivamente
    final clienteData = argumentsList[0];
    final fechaData = argumentsList[1];
    //Se inicializan los controllers para el TextField, con los datos previos recuperados
    clientController.text = clienteData;
    fechaController.text = fechaData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar Incidencia'),
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
              onPressed: () async{
                //NO FUNCIONA LA FUNCION UPDATE ME ESTOY VOLVIENDO LOCOOOOOOOOOOOOOOOOOOOOOOO
                await updateIncident(argumentsList[2] ,clientController.text, fechaController.text).then((value) => 
                  Navigator.pop(context)
                );
                //Actualizar la lista de incidencias
                setState(() {});
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}