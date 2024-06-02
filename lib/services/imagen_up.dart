import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:image_picker/image_picker.dart";

final FirebaseStorage storage = FirebaseStorage.instance;

// Selecciona una imagen de la galeria
Future<XFile?> getImagen() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

  return imagen;
}

// Selecciona una imagen de la camara
Future<XFile?> getImagenCamara() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagen = await picker.pickImage(source: ImageSource.camera);

  return imagen;
}

//Metodo para subir una imagen a la base de datos
Future<bool> subirImagen(File imagen) async {
  print (imagen.path);


  final String nameFile = imagen.path.split('/').last;
  final Reference upload = storage.ref().child("imagenes").child(nameFile);
  final UploadTask uploadTask = upload.putFile(imagen);
  print(UploadTask);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  final String downloadUrl = await snapshot.ref.getDownloadURL();

  print(downloadUrl);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}