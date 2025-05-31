import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/models.dart';


class ImageService {
  final String baseUrl = "http://localhost/php_nyetop"; // sesuaikan dengan IP/port server kamu

  // Upload gambar ke server
  Future<bool> uploadImage(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/get_image.php'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final data = jsonDecode(respStr);
      return data['success'] == true;
    } else {
      return false;
    }
  }

  // Ambil gambar base64 dari server berdasarkan id
  Future<Image?> fetchImageFromBase64(String id) async {
  final url = Uri.parse('http://192.168.1.12/php_nyetop/get_image.php?id=$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final base64Str = data['image'];
    if (base64Str == null) return null;

    final bytes = base64Decode(base64Str);
    return Image.memory(bytes, fit: BoxFit.cover);
  } else {
    return null;
  }
}


Future<List<Gambar>> fetchGambar(String id) async {
  final response = await http.get(Uri.parse('http://192.168.1.12/php_nyetop/get_image.php?id=$id'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Gambar.fromJson(data)).toList();
  } else {
    throw Exception('Gagal memuat data');
  }
}

}
