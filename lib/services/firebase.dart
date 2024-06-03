import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


//CRUD READ
Future<List> getIncidents() async {
  List incidents = [];
  //Crear referencia apuntando a la tabla
  CollectionReference collectionReferenceIncidents = db.collection('incidencia');
  //Generar la query para leer todos los datos
  QuerySnapshot queryIncidents = await collectionReferenceIncidents.get();

  for (var doc in queryIncidents.docs) { 
    final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
    final incidencia = {
      'cliente': docData['cliente'],
      'fecha': docData['fecha'],
      'id': doc.id,
      'descripcion': docData['descripcion'],
      'tipo': docData['tipo'],
      'estado': docData['estado'],
      'imagen': docData['imagen'],
    };
    incidents.add(incidencia);
  }

  return incidents;
}

//CRUD CREATE
Future<void> createIncident(String cliente, String fecha, String descripcion, String tipo, String estado, String linkImagen) async {
  await db.collection('incidencia').add({
    'cliente': cliente,
    'fecha': fecha,
    'descripcion': descripcion,
    'tipo': tipo,
    'estado': estado,
    'imagen': linkImagen,
  });
}

//CRUD UPDATE
Future<void> updateIncident(String id ,String cliente, String fecha, String descripcion, String tipo, String estado) async {
  await db.collection('incidencia').doc(id).update({
    'cliente': cliente,
    'fecha': fecha,
    'descripcion': descripcion,
    'tipo': tipo,
    'estado': estado,
  });
}

//CRUD DELETE
Future<void> deleteIncident(String id) async {
  await db.collection('incidencia').doc(id).delete();
}