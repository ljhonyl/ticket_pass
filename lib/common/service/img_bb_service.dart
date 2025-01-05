import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ImgBBService {

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse("https://api.imgbb.com/1/upload");
    final bytes = await imagen.readAsBytes();
    final base64Image = base64Encode(bytes);
    final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('recursos').doc('St0iJhubtCIxjhl1OU82').get();
    final String constante = doc['key'];


    final response = await http.post(
      url,
      body: {
        "key": constante,
        "image": base64Image,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['url'];
    } else {
      throw Exception("Error al subir la imagen: ${response.body}");
    }
  }

  Future<List<String>> subirImagenes(List<File> imagenes) async {
    final urls = <String>[];

    for (final imagen in imagenes) {
      final url = await subirImagen(imagen);
      urls.add(url);
    }

    return urls;
  }
}
