// models/wishlist_item.dart
import 'package:flutter/material.dart';

class WishlistItem {
  final String id;
  final String nama;
  final String harga;
  final String deskripsi;
  final Widget? imageWidget;
  final String imagePath;
  final DateTime addedAt;
  final String? kategori;
  final String? lokasi;

  WishlistItem({
    required this.id,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    this.imageWidget,
    required this.imagePath,
    DateTime? addedAt,
    this.kategori,
    this.lokasi,
  }) : addedAt = addedAt ?? DateTime.now();

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'imagePath': imagePath,
      'addedAt': addedAt.toIso8601String(),
      'kategori': kategori,
      'lokasi': lokasi,
    };
  }

  // Create from Map
  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      harga: map['harga'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      imagePath: map['imagePath'] ?? '',
      addedAt: DateTime.tryParse(map['addedAt'] ?? '') ?? DateTime.now(),
      kategori: map['kategori'],
      lokasi: map['lokasi'],
    );
  }

  // Create from Firebase document
  factory WishlistItem.fromFirebase(Map<String, dynamic> data) {
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