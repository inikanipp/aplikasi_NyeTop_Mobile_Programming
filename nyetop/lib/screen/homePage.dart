import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyetop/screen/loginPage.dart';
import 'package:nyetop/screen/ProfilPage.dart';
import 'package:nyetop/widget/navbar.dart';
import 'package:nyetop/widget/card.dart';
import 'package:nyetop/widget/serachBar.dart';
import 'package:nyetop/screen/addItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../service/imageService.dart';
import '../widget/wishlist_badge.dart';
import 'package:nyetop/shared/theme.dart';

class HomePage extends StatefulWidget {
  final String id_user;
  final String imageId;
  const HomePage({super.key, required this.id_user, required this.imageId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImageService _imageService = ImageService();
  String? _base64Image;
  bool _isLoading = true;
  String _userName = "Agus";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.id_user)
          .get();
      
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userName = userData['name'] ?? 'User';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(16),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilPage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/img_profile.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Text(
                              "Halo, $_userName",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/wishlist');
                        },
                        child: const WishlistBadge(),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, '/notifications');
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/active/notif.svg",
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Temukan Laptop yang kamu butuhkan",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Dengan spesifikasi dan harga terbaik",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFA1A1A1),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: searchBar()),
                    const SizedBox(width: 13),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 53,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: const Color(0xFF060A56),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/nonactive/filter.svg",
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('laptops')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Image.asset("assets/images/load.gif"),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.laptop_mac,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Belum ada laptop tersedia',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final laptops = snapshot.data!.docs;

                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: laptops.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 182 / 234,
                            ),
                            itemBuilder: (context, index) {
                              final data =
                                  laptops[index].data() as Map<String, dynamic>;
                              final String docId = laptops[index].id;

                              return GestureDetector(
                                onTap: () {
                                  // Kirim semua data laptop ke detail page
                                  Navigator.pushNamed(
                                    context,
                                    '/laptop-detail',
                                    arguments: {
                                      'laptopId': docId,
                                      'laptopData': data, // Kirim semua data
                                      'nama': data['nama'] ?? 'Unknown',
                                      'harga': data['harga']?.toString() ?? '0',
                                      'deskripsi': data['deskripsi'] ?? '',
                                      'processor': data['processor'] ?? '',
                                      'ram': data['ram'] ?? '',
                                      'storage': data['storage'] ?? '',
                                      'display': data['display'] ?? '',
                                      'graphics': data['graphics'] ?? '',
                                      'os': data['os'] ?? '',
                                      'penjual': data['penjual'] ?? '',
                                    },
                                  );
                                },
                                child: FutureBuilder<Image?>(
                                  future: _imageService.fetchGambar(docId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return cardLaptop(
                                        judul: data['nama'] ?? 'Unknown',
                                        harga: data['harga']?.toString() ?? '0',
                                        deskripsi: data['deskripsi'] ?? '',
                                        imageWidget: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        itemId: docId,
                                        laptopData: data, // Tambahkan ini
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      return cardLaptop(
                                        judul: data['nama'] ?? 'Unknown',
                                        harga: data['harga']?.toString() ?? '0',
                                        deskripsi: data['deskripsi'] ?? '',
                                        imageWidget: Container(
                                          height: 120,
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        itemId: docId,
                                        laptopData: data, // Tambahkan ini
                                      );
                                    }

                                    return cardLaptop(
                                      judul: data['nama'] ?? 'Unknown',
                                      harga: data['harga']?.toString() ?? '0',
                                      deskripsi: data['deskripsi'] ?? '',
                                      imageWidget: snapshot.data!,
                                      itemId: docId,
                                      laptopData: data, // Tambahkan semua data laptop
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 100,
              child: FloatingActionButton(
                backgroundColor: const Color(0XFF060A56),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addItems(idUser: widget.id_user),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Filter Laptop',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Harga Terendah'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement filter logic
                },
              ),
              ListTile(
                title: Text('Harga Tertinggi'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement filter logic
                },
              ),
              ListTile(
                title: Text('Terbaru'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement filter logic
                },
              ),
              ListTile(
                title: Text('Terlama'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement filter logic
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}