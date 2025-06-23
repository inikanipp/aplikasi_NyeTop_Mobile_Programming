// services/seller_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/seller_model.dart';

class SellerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ambil data penjual berdasarkan user ID
  Future<SellerModel?> getSellerById(String sellerId) async {
    try {
      if (sellerId.isEmpty) {
        print('Seller ID is empty');
        return null;
      }

      DocumentSnapshot doc = await _firestore
          .collection('users') // atau 'sellers' sesuai struktur Anda
          .doc(sellerId)
          .get();

      if (doc.exists && doc.data() != null) {
        return SellerModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      
      print('Seller document does not exist for ID: $sellerId');
      return null;
    } catch (e) {
      print('Error getting seller: $e');
      return null;
    }
  }

  // Ambil data penjual dengan real-time updates
  Stream<SellerModel?> getSellerStream(String sellerId) {
    if (sellerId.isEmpty) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(sellerId)
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        return SellerModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    });
  }

  // Simpan/Update data penjual
  Future<bool> saveSeller(SellerModel seller) async {
    try {
      await _firestore
          .collection('users')
          .doc(seller.sellerId)
          .set(seller.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Error saving seller: $e');
      return false;
    }
  }

  // Update rating penjual
  Future<bool> updateSellerRating(String sellerId, double newRating, int totalReviews) async {
    try {
      await _firestore
          .collection('users')
          .doc(sellerId)
          .update({
        'rating': newRating,
        'totalReviews': totalReviews,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error updating seller rating: $e');
      return false;
    }
  }

  // Cek apakah penjual ada
  Future<bool> sellerExists(String sellerId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(sellerId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking seller existence: $e');
      return false;
    }
  }

  // Ambil semua penjual (untuk admin)
  Future<List<SellerModel>> getAllSellers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'seller') // jika ada field role
          .get();

      return snapshot.docs
          .map((doc) => SellerModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error getting all sellers: $e');
      return [];
    }
  }
}