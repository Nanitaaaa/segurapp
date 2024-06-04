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
  TextEditingController descController = TextEditingController(text: '' );
  TextEditingController tipoController = TextEditingController(text: '');
  TextEditingController estadoController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    //Acceder a los argumentos pasados por el ModalRoute
    final arguments = ModalRoute.of(context)!.settings.arguments as Set<dynamic>;
    List<dynamic> argumentsList = arguments.toList();
    //Dentro de la lista, se obtienen los datos del cliente y la fecha en las posiciones 0 y 1, respectivamente
    final clienteData = argumentsList[0];
    final fechaData = argumentsList[1];
    final descData = argumentsList[3];
    //tipos = argumentsList[4]; //Con esto consigo mostrar el tipo actual al ser mostrado pero si lo descomento genera un error que no deja modificar campos.
    //estado = argumentsList[5]; //lo mismo con esto, para solucionarlo usaré TextEditingController para trabajar estas partes
    final tipoData = argumentsList[4];
    final estadoData = argumentsList[5];
    final imagen = argumentsList[6];

    //Se inicializan los controllers para el TextField, con los datos previos recuperados
    clientController.text = clienteData;
    fechaController.text = fechaData;
    descController.text = descData;
    tipoController.text = tipoData;
    estadoController.text = estadoData;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          final confirmed = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Confirmar'),
                content: const Text('¿Está seguro que desea eliminar esta incidencia?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Sí, eliminar'),
                  ),
                ],
              );
            },
          );

          if (confirmed ?? false) {
            // Si confimamos la eliminación, llamamos a la función deleteIncident
            await deleteIncident(argumentsList[2]);
            // ignore: use_build_context_synchronously
            Navigator.pop(context); // Volvemos al menú principal
          }
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text('Modificar Incidencia'),
      ),
      body: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SingleChildScrollView( // Agregado SingleChildScrollView
        child: Column(
          children: [
            TextField( 
              controller: clientController,
              decoration: const InputDecoration(
                labelText: 'Ingrese nombre del usuario',
              ),
            ),
        
            TextField( 
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Ingrese la fecha de la incidencia',
              ),
            ),

            TextField( 
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Descripción de la incidencia',
              ),
            ),

            TextField( 
              controller: tipoController,
              decoration: const InputDecoration(
                labelText: 'Tipo de incidencia',
              ),
            ),
            
            Container(
              margin: const EdgeInsets.all(10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: imagen != ''
                  ? Image.network(imagen!) // Mostrar imagen si está existe
                  : const Center(
                      child: Text(// Mostrar texto si no hay imagen
                        "Imagen no seleccionada",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ), 
            ),
             ElevatedButton(
              onPressed: () {
                if (estadoController.text == 'Abierta') {
                  estadoController.text = 'Cerrada';
                } else {
                  estadoController.text = 'Abierta';
                }
                updateState(argumentsList[2], estadoController.text);
                Navigator.pop(context, true); //Retorna a 'true' para indicar un cambio de estado
              },
              child: Text(estadoController.text == 'Abierta' ? 'Cerrar Incidencia' : 'Reabrir Incidencia'),
            ),
            
            ElevatedButton(
              onPressed: () async{
                //Actualizar la incidencia en la base de datos
                await updateIncident(argumentsList[2] ,clientController.text, fechaController.text, descController.text, tipoController.text, estadoController.text).then((value) => 
                  Navigator.pop(context)
                );
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    ));
  }
}