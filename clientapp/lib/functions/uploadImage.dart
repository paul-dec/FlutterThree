import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

Future<String> uploadImage() async {
  final file = await ImagePicker().pickImage(source: ImageSource.gallery);

  TaskSnapshot uploadTask;
  Reference ref = FirebaseStorage.instance.ref("gs://flutterthree.appspot.com/").child(file!.name);
  final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path});

  if (kIsWeb) {
    uploadTask = (await ref.putData(await file.readAsBytes(), metadata));
  } else {
    uploadTask = (await ref.putFile(io.File(file.path), metadata));
  }

  final link = await uploadTask.ref.getDownloadURL();

  return link;
}