import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


//CRUD READ
Future<List> getIncidents() async {
  List incidents = [];
  //Crear referencia apuntando a la tabla
  CollectionReference collectionReferenceIncidents = db.collection('incidencia');
  //Generar la query para leer todos los datos
  QuerySnapshot queryIncidents = await collectionReferenceIncidents.get();

  for (var document in queryIncidents.docs) { 
    incidents.add(document.data());
  }

  await Future.delayed( const Duration(milliseconds: 500 ));

  return incidents;
}