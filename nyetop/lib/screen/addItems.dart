import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyetop/widget/addFile.dart';
import 'package:nyetop/widget/field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../service/imageService.dart';

class addItems extends StatefulWidget {
  final String idUser;
  const addItems({super.key, required this.idUser});

  @override
  State<addItems> createState() => _addItemsState();
}

class _addItemsState extends State<addItems> {
  final _formKey = GlobalKey<FormState>();
  final ImageService imageService = ImageService();

  File? imageFile;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? namaItem;
  String? jenisItem;
  String? hargaItem;
  String? deskripsiItem;
  String? currentAddress;
  Position? currentPosition;

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      namaItem = null;
      jenisItem = null;
      hargaItem = null;
      deskripsiItem = null;
      currentAddress = null;
      imageFile = null;
    });
    _getCurrentLocation(); // ambil ulang lokasi
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Permission permanently denied');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          currentAddress =
              "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      print("Error geocoding: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddFile(
                imageFile: imageFile,
                onTap: pickImage,
              ),
              SizedBox(height: 16),
              field(
                line: 1,
                name: "Nama Item",
                onSaved: (value) => namaItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama item wajib diisi' : null,
              ),
              SizedBox(height: 16),
              field(
                line: 1,
                name: "Jenis Item",
                onSaved: (value) => jenisItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Jenis item wajib diisi' : null,
              ),
              SizedBox(height: 16),
              field(
                line: 1,
                name: "Harga",
                onSaved: (value) => hargaItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Harga wajib diisi' : null,
              ),
              SizedBox(height: 16),
              field(
                line: 4,
                name: "Deskripsi",
                onSaved: (value) => deskripsiItem = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              SizedBox(height: 16),
              Text(
                "Lokasi Saat Ini",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                currentAddress ?? "Mendeteksi lokasi...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF060A56),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Silakan pilih gambar terlebih dahulu.")),
                        );
                        return;
                      }

                      try {
                        // 1. Tambahkan data ke Firestore dan ambil doc.id
                        final docRef = await firestore.collection('laptops').add({
                          'nama': namaItem,
                          'jenis': jenisItem, // Sekarang menggunakan jenisItem yang terpisah
                          'harga': hargaItem,
                          'lokasi': currentAddress,
                          'deskripsi': deskripsiItem,
                          'user': widget.idUser,
                        });

                        final idDoc = docRef.id;

                        // 2. Upload gambar dan gunakan idDoc sebagai id untuk MySQL
                        await imageService.uploadImage(imageFile!, idDoc);

                        // 3. Update dokumen Firestore untuk menyimpan nama gambar (jika mau)
                        await docRef.update({'imageId': idDoc});

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data berhasil disubmit!")),
                        );
                        _resetForm();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Terjadi kesalahan: $e")),
                        );
                      }
                    }
                  },

                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: _resetForm,
                  child: Text(
                    "Reset",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF060A56),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}