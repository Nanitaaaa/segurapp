import 'package:flutter/material.dart';

//Importaciones para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: FormularioPrincipal(),
  ));
}

class FormularioPrincipal extends StatefulWidget {
  const FormularioPrincipal({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioPrincipalState createState() => _FormularioPrincipalState();
}

class _FormularioPrincipalState extends State<FormularioPrincipal> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario XD'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            ElevatedButton(
              child: const Text('Borrar'),
              onPressed: () {
                _nombreController.clear();
              },
            ),
            ElevatedButton(
              child: const Text('Saludar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaSaludo(_nombreController.text),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaSaludo extends StatelessWidget {
  final String nombre;

  const PantallaSaludo(this.nombre, {super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Saludo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Hola $nombre'),
            ElevatedButton(
              child: const Text('Volver al Formulario Principal'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
