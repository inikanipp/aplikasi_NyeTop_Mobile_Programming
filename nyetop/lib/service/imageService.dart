import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class ImageService {
  Future<Image?> fetchGambar(String id) async {
  final response = await http.get(
    Uri.parse('http://192.168.1.11/php_nyetop/get_image.php?id=$id'),
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    if (data.isEmpty) return null;

    final String base64Image = data[0]['image'];
    Uint8List bytes = base64Decode(base64Image);
    return Image.memory(bytes, fit: BoxFit.cover);
  } else {
    throw Exception("Gagal ambil gambar");
  }
}



  Future<void> uploadImage(File imageFile, String idDoc) async {
    var uri = Uri.parse("http://192.168.1.11/php_nyetop/post.php");

    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = idDoc;
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    print("Response dari server: $respStr"); // Debug penting

    if (response.statusCode == 200) {
      print("Upload sukses");
    } else {
      throw Exception("Upload gagal: $respStr");
    }
  }



}
