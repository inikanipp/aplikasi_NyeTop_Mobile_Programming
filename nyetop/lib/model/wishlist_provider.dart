// models/wishlist_provider.dart
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'wishlist_item.dart';
import '../service/firebase_service.dart';

class WishlistProvider with ChangeNotifier {
  List<WishlistItem> _wishlistItems = [];
  final FirebaseService _firebaseService = FirebaseService();
  static const String _storageKey = 'wishlist_items';

  List<WishlistItem> get wishlistItems => _wishlistItems;
  int get wishlistCount => _wishlistItems.length;

  bool isInWishlist(String itemId) {
    return _wishlistItems.any((item) => item.id == itemId);
  }

  Future<void> addToWishlist(WishlistItem item) async {
    if (!isInWishlist(item.id)) {
      _wishlistItems.add(item);
      await _saveWishlist();
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(String itemId) async {
    _wishlistItems.removeWhere((item) => item.id == itemId);
    await _saveWishlist();
    notifyListeners();
  }

  Future<void> toggleWishlist(WishlistItem item) async {
    if (isInWishlist(item.id)) {
      await removeFromWishlist(item.id);
    } else {
      await addToWishlist(item);
    }
  }

  Future<void> clearWishlist() async {
    _wishlistItems.clear();
    await _saveWishlist();
    notifyListeners();
  }

  // Mengambil item dari Firebase berdasarkan ID dan menambahkan ke wishlist
  Future<void> addFirebaseItemToWishlist(String itemId) async {
    try {
      final itemData = await _firebaseService.getLaptopById(itemId);
      if (itemData != null) {
        final wishlistItem = WishlistItem.fromFirebase(itemData);
        await addToWishlist(wishlistItem);
      }
    } catch (e) {
      print('Error adding Firebase item to wishlist: $e');
    }
  }

  // Memuat ulang data dari Firebase untuk item yang ada di wishlist
  Future<void> refreshWishlistFromFirebase() async {
    try {
      List<WishlistItem> updatedItems = [];
      
      for (WishlistItem item in _wishlistItems) {
        final updatedData = await _firebaseService.getLaptopById(item.id);
        if (updatedData != null) {
          final updatedItem = WishlistItem.fromFirebase(updatedData);
          updatedItems.add(updatedItem);
        } else {
          // Jika item tidak ditemukan di Firebase, tetap simpan versi lokal
          updatedItems.add(item);
        }
      }
      
      _wishlistItems = updatedItems;
      await _saveWishlist();
      notifyListeners();
    } catch (e) {
      print('Error refreshing wishlist from Firebase: $e');
    }
  }

  Future<void> _saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistJson = _wishlistItems.map((item) => item.toMap()).toList();
      await prefs.setString(_storageKey, json.encode(wishlistJson));
    } catch (e) {
      print('Error saving wishlist: $e');
    }
  }

  Future<void> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistString = prefs.getString(_storageKey);
      
      if (wishlistString != null) {
        final List wishlistJson = json.decode(wishlistString);
        _wishlistItems = wishlistJson
            .map((item) => WishlistItem.fromMap(item))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading wishlist: $e');
    }
  }
}