// services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/wishlist_item.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Mengambil data laptop dari Firestore
  Future<List<Map<String, dynamic>>> getLaptops() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('laptops')
          .get();
      
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Menambahkan document ID
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching laptops: $e');
      return [];
    }
  }
  
  // Mengambil laptop berdasarkan ID
  Future<Map<String, dynamic>?> getLaptopById(String laptopId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('laptops')
          .doc(laptopId)
          .get();
      
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      print('Error fetching laptop by ID: $e');
      return null;
    }
  }
  
  // Mencari laptop berdasarkan nama atau kategori
  Future<List<Map<String, dynamic>>> searchLaptops(String query) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('laptops')
          .where('nama', isGreaterThanOrEqualTo: query)
          .where('nama', isLessThanOrEqualTo: query + '\uf8ff')
          .get();
      
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error searching laptops: $e');
      return [];
    }
  }
  
  // Mengambil laptop berdasarkan kategori
  Future<List<Map<String, dynamic>>> getLaptopsByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('laptops')
          .where('kategori', isEqualTo: category)
          .get();
      
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching laptops by category: $e');
      return [];
    }
  }
  
  // Convert Firebase data to WishlistItem
  WishlistItem firebaseToWishlistItem(Map<String, dynamic> data) {
    return WishlistItem(
      id: data['id'] ?? '',
      nama: data['nama'] ?? '',
      harga: data['harga']?.toString() ?? '',
      deskripsi: data['deskripsi'] ?? '',
      imagePath: data['gambar'] ?? '', // Sesuaikan dengan field di Firestore
      kategori: data['kategori'],
      lokasi: data['lokasi'],
    );
  }
}