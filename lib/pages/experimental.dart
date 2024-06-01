import 'dart:io';

import 'package:flutter/material.dart';
import 'package:segurapp/services/imagen_up.dart';

class ExperimentalPage extends StatefulWidget {
  const ExperimentalPage({super.key});

  @override
  State<ExperimentalPage> createState() => _ExperimentalPageState();
}

class _ExperimentalPageState extends State<ExperimentalPage> {

  File? imagenUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experimental'),
      ),
      body: Column(
        children: [
          imagenUpload != null ? Image.file(imagenUpload!) : Container(
            margin: const EdgeInsets.all(10),
            height: 200,
            width: double.infinity,
            color: Colors.blue,
          ),
          ElevatedButton(
            onPressed: () async {
              final imagen = await getImagen();
              setState(() {
                imagenUpload = File(imagen!.path);
              });
            }, 
            child: 
              const Text('Seleccionar imagen')),
          ElevatedButton(onPressed: (){}, child: const Text('Subir imagen')),
        ],
      ),
    );
  }
}