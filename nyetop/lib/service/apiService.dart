import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/models.dart';

class ApiService {
  final String baseUrl = "https://nyetop-59228-default-rtdb.firebaseio.com/users";

  // GET request
  Future<List<catatanApi>> fetchUser(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<catatanApi> list = [];

      data.forEach((key, value) {
        list.add(catatanApi.fromJson(value, key));
      });

      return list; 
    } else {
      print("Status code: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception('Failed to load data');
    }
  }

  // POST request
 Future<void> createUser(String name) async {
  final response = await http.put(
    Uri.parse('$baseUrl/$name.json'), // ← Custom key dimasukkan di URL
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      'id': name,
      'username': name,
    }),
  );

  if (response.statusCode == 200) {
    print("User with custom ID created!");
  } else {
    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");
    throw Exception('Failed to create user');
  }
}


   // DELETE request
  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id.json'));

    if (response.statusCode == 200) {
      print("User deleted!");
    } else {
      print("Status code: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception('Failed to delete user');
    }
  }

  // UPDATE request (PATCH)
  Future<void> updateUser(String id, String judul, String jenis, String deskripsi) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id.json'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'judul': judul,
        'jenis': jenis,
        'deskripsi': deskripsi,
      }),
    );

    if (response.statusCode == 200) {
      print("User updated!");
    } else {
      throw Exception('Failed to update user');
    }
  }
}
