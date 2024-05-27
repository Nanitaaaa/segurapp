import 'package:flutter/material.dart';
import 'listadoincidencias.dart';

// Lista global para almacenar las incidencias
List<Incidencia> listaIncidencias = [];
int contadorIncidencias = 1;

// Clase que define la estructura de una incidencia
class Incidencia {
  final String id;
  final String categoria;
  final String descripcion;
  String estado;

  Incidencia({
    required this.id,
    required this.categoria,
    required this.descripcion,
    this.estado = 'Abierto',
  });
}

// Widget principal para registrar incidencias
class RegistrarIncidencia extends StatefulWidget {
  const RegistrarIncidencia({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrarIncidenciaState createState() => _RegistrarIncidenciaState();
}

class _RegistrarIncidenciaState extends State<RegistrarIncidencia> {
  // Controlador para el campo de texto de la descripción
  final TextEditingController descripcionController = TextEditingController();
  String _tipoIncidencia = '';
  final List<String> _tiposIncidencia = [
    'Robo / Asalto',
    'Extravío',
    'Violencia doméstica',
    'Accidente tránsito',
    'Actividad sospechosa',
    'Disturbios',
    'Incendio',
    'Cortes de transito',
    'Portonazo',
    'Otro..',
  ];

  // Función para mostrar el diálogo de selección de tipo de incidencia
  void _showTipoIncidenciaDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Seleccione el Tipo de Incidencia'),
          children: [
            SizedBox(
              height: 200, // Ajusta la altura según sea necesario
              width: 300, // Ajusta el ancho según sea necesario
              child: Scrollbar(
                thumbVisibility: true, // Asegura que el scrollbar sea visible
                child: ListView(
                  children: _tiposIncidencia.map((tipo) {
                    return RadioListTile<String>(
                      title: Text(tipo),
                      value: tipo,
                      groupValue: _tipoIncidencia,
                      onChanged: (String? value) {
                        setState(() {
                          _tipoIncidencia = value ?? '';
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Función para guardar una nueva incidencia en la lista
  void _guardarIncidencia(String categoria, String descripcion) {
    Incidencia incidencia = Incidencia(
      id: contadorIncidencias.toString(),
      categoria: categoria,
      descripcion: descripcion,
      estado: 'Abierto',
    );
    setState(() {
      listaIncidencias.add(incidencia);
      contadorIncidencias++;
    });
  }

  // Función para registrar una nueva incidencia
  void _registrarIncidencia() {
    if (_tipoIncidencia.isEmpty || descripcionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe seleccionar un tipo de incidencia y proporcionar una descripción.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Confirmar Registro'),
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              // ignore: prefer_const_constructors
              child: Text('¿Está seguro de que desea registrar esta incidencia?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Editar'),
                ),
                TextButton(
                  onPressed: () {
                    _guardarIncidencia(_tipoIncidencia, descripcionController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incidencia registrada exitosamente.'),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaIncidencias(),
                      ),
                    );
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Incidencia'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showTipoIncidenciaDialog(context);
                  },
                  child: const Text('Tipo de Incidencia'),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: descripcionController,
                    decoration: const InputDecoration(
                      hintText: 'Descripción de Incidencia (max 500 caracteres)',
                    ),
                    maxLines: null,
                    maxLength: 500,
                  ),
                ),
                ElevatedButton(
                  onPressed: _registrarIncidencia,
                  child: const Text('Registrar'),
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
        ),
      ),
    );
  }
}
