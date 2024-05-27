import 'package:flutter/material.dart';
import 'registrarIncidencia.dart';

// Clase principal para la lista de incidencias
class ListaIncidencias extends StatefulWidget {
  const ListaIncidencias({super.key});

  @override
  _ListaIncidenciasState createState() => _ListaIncidenciasState();
}

// Estado de la clase ListaIncidencias
class _ListaIncidenciasState extends State<ListaIncidencias> {
  // Función para actualizar el estado de una incidencia
  void _actualizarEstadoIncidencia(Incidencia incidencia) {
    setState(() {
      incidencia.estado = incidencia.estado == 'Abierto' ? 'Cerrado' : 'Abierto';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Incidencias'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaIncidencias.length,
              itemBuilder: (context, index) {
                final incidencia = listaIncidencias[index];
                return ListTile(
                  title: Text('ID: ${incidencia.id} - ${incidencia.categoria}'),
                  subtitle: Text(incidencia.descripcion),
                  trailing: Text(incidencia.estado),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleIncidencia(incidencia: incidencia),
                      ),
                    );

                    if (result == true) {
                      setState(() {
                        // Actualizar la lista de incidencias si hubo algún cambio
                      });
                    }
                  },
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              child: const Text('Regresar al Menú Principal'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Clase para mostrar el detalle de una incidencia
class DetalleIncidencia extends StatelessWidget {
  final Incidencia incidencia;

  const DetalleIncidencia({super.key, required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${incidencia.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Categoría: ${incidencia.categoria}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Descripción: ${incidencia.descripcion}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Estado: ${incidencia.estado}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (incidencia.estado == 'Abierto') {
                  incidencia.estado = 'Cerrado';
                } else {
                  incidencia.estado = 'Abierto';
                }
                Navigator.pop(context, true); //Retorna a 'true' para indicar un cambio de estado
              },
              child: Text(incidencia.estado == 'Abierto' ? 'Cerrar Incidencia' : 'Reabrir Incidencia'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false); //Retorna a 'false' si no hay cambio de estado
              },
              child: const Text('Volver al Listado'),
            ),
          ],
        ),
      ),
    );
  }
}
