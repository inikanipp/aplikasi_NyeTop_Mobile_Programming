import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyetop/screen/loginPage.dart';
import 'package:nyetop/widget/navbar.dart';
import 'package:nyetop/widget/card.dart';
import 'package:nyetop/widget/serachBar.dart';
import 'package:nyetop/screen/addItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../service/imageService.dart';

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

  // @override
  // void initState() {
  //   super.initState();
  //   _loadImage();
  // }

  // Future<void> _loadImage() async {
  //   final image = await _imageService.fetchImageBase64(widget.imageId);
  //   setState(() {
  //     _base64Image = image.toString();
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(16),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // print('gambar ditekan');
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
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
                              "Halo, Agus",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () async {
                            // await FirebaseAuth.instance.signOut();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Loginpage(),
                            //   ),
                            // );
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
                    color: Color(0xFFA1A1A1),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: searchBar()),
                    SizedBox(width: 13),
                    GestureDetector(
                      onTap: () => print("filter"),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: 53,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Color(0xFF060A56),
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
                    padding: EdgeInsets.only(top: 1),
                    child: StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
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
                          return Center(child: Text('Tidak ada data.'));
                        }

                        final laptops = snapshot.data!.docs;

                        return GridView.builder(
                          itemCount: laptops.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 182 / 234,
                              ),
                          itemBuilder: (context, index) {
                            final data =
                                laptops[index].data() as Map<String, dynamic>;
                            final String idGambar = data['user'];
                            final String docId = laptops[index].id;
                            print("ID UNIQ : $docId");

                            return FutureBuilder<Image?>(
                              future: _imageService.fetchGambar(docId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return cardLaptop(
                                    judul: data['nama'],
                                    harga: data['harga'].toString(),
                                    deskripsi: data['deskripsi'],
                                    imageWidget: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return cardLaptop(
                                    judul: data['nama'],
                                    harga: data['harga'].toString(),
                                    deskripsi: data['deskripsi'],
                                    imageWidget: Icon(Icons.broken_image),
                                  );
                                }
                                return cardLaptop(
                                  judul: data['nama'],
                                  harga: data['harga'].toString(),
                                  deskripsi: data['deskripsi'],
                                  imageWidget: snapshot.data!,
                                );
                              },
                            );
                          },
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
                backgroundColor: Color(0XFF060A56),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addItems(idUser: widget.id_user),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// widget profile
