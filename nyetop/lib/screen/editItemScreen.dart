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

class EditItemScreen extends StatefulWidget {
  final String idUser;
  final DocumentSnapshot documentSnapshot;
  
  const EditItemScreen({
    super.key,
    required this.idUser,
    required this.documentSnapshot,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImageService imageService = ImageService();

  File? imageFile;
  Image? currentImage;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Controllers untuk form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? namaItem;
  String? hargaItem;
  String? deskripsiItem;
  String? currentAddress;
  Position? currentPosition;
  bool isImageChanged = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _getCurrentLocation();
    _loadCurrentImage();
  }

  void _initializeData() {
    var data = widget.documentSnapshot.data() as Map<String, dynamic>;
    
    _namaController.text = data['nama'] ?? '';
    _hargaController.text = data['harga'] ?? '';
    _deskripsiController.text = data['deskripsi'] ?? '';
    currentAddress = data['lokasi'] ?? '';
    
    namaItem = data['nama'];
    hargaItem = data['harga'];
    deskripsiItem = data['deskripsi'];
  }

  Future<void> _loadCurrentImage() async {
    try {
      Image? image = await imageService.fetchGambar(widget.documentSnapshot.id);
      if (image != null) {
        setState(() {
          currentImage = image;
        });
      }
    } catch (e) {
      print("Error loading current image: $e");
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
        isImageChanged = true;
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

  Future<void> _updateItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Tampilkan loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        // Update data di Firestore
        await firestore.collection('laptops').doc(widget.documentSnapshot.id).update({
          'nama': namaItem,
          'jenis': deskripsiItem,
          'harga': hargaItem,
          'lokasi': currentAddress,
          'deskripsi': deskripsiItem,
        });

        // Upload gambar baru jika ada perubahan
        if (isImageChanged && imageFile != null) {
          await imageService.uploadImage(imageFile!, widget.documentSnapshot.id);
        }

        // Tutup loading dialog
        Navigator.pop(context);

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data berhasil diupdate!"),
            backgroundColor: Colors.green,
          ),
        );

        // Kembali ke halaman sebelumnya
        Navigator.pop(context);
      } catch (e) {
        // Tutup loading dialog
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Terjadi kesalahan: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Item',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF060A56),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar current atau gambar baru
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageFile != null
                    ? Image.file(imageFile!, fit: BoxFit.cover)
                    : currentImage != null
                        ? currentImage!
                        : Center(
                            child: Text(
                              'Tidak ada gambar',
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Ganti Gambar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Form fields
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Item',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama item wajib diisi' : null,
                onSaved: (value) => namaItem = value,
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Harga wajib diisi' : null,
                onSaved: (value) => hargaItem = value,
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                maxLines: 4,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
                onSaved: (value) => deskripsiItem = value,
              ),
              SizedBox(height: 16),
              
              Text(
                "Lokasi Saat Ini",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  currentAddress ?? "Mendeteksi lokasi...",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Tombol Update
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF060A56),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _updateItem,
                  child: Text(
                    "Update Item",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              
              // Tombol Batal
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF060A56)),
                    foregroundColor: Color(0xFF060A56),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Batal",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}