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
  String tipos = 'otro';
  String estado = 'Abierta';

  @override
  Widget build(BuildContext context) {
    //Acceder a los argumentos pasados por el ModalRoute
    final arguments = ModalRoute.of(context)!.settings.arguments as Set<dynamic>;
    List<dynamic> argumentsList = arguments.toList();
    //Dentro de la lista, se obtienen los datos del cliente y la fecha en las posiciones 0 y 1, respectivamente
    final clienteData = argumentsList[0];
    final fechaData = argumentsList[1];
    final descData = argumentsList[3];
    //TODO: Arreglar la logica de mostrar el tipo y estado actual de la incidencia
    //tipos = argumentsList[4]; //Con esto consigo mostrar el tipo actual al ser mostrado pero si lo descomento genera un error que no deja modificar campos.
    //estado = argumentsList[5]; //lo mismo con esto
    final imagen = argumentsList[6];

    //Se inicializan los controllers para el TextField, con los datos previos recuperados
    clientController.text = clienteData;
    fechaController.text = fechaData;
    descController.text = descData;
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
            const Text('Seleccione el tipo de incidencia'),
            DropdownButton<String>(
              value: tipos,
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
                  tipos = newValue!;
                });
              },
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

            DropdownButton<String>(
              value: estado,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String ?newValue) {
                setState(() {
                  estado = newValue!;
                });
              },
              items: <String>['Abierta', 'En atención', 'Cerrada']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            ),
            
            ElevatedButton(
              onPressed: () async{
                //Actualizar la incidencia en la base de datos
                await updateIncident(argumentsList[2] ,clientController.text, fechaController.text, descController.text, tipos, estado).then((value) => 
                  Navigator.pop(context)
                );
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}