import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Detailpage extends StatelessWidget {
  final String nama;
  final String harga;
  final String deskripsi;
  const Detailpage({super.key,
    required this.nama,
    required this.harga,
    required this.deskripsi
  
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.red,
              height: 410,
              padding: EdgeInsets.only(bottom: 12, right: 12, left: 12),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        // color: Colors.green,
                        height: 22,
                        width: double.infinity,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/laptop.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Tanggal bulat
                  Container(
                    width: 104,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Color(0xFF060A56),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "15 Mei",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Glassmorphism area
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      
                      children: [
                        // Glassmorphism Container di sebelah kiri
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              // Blur layer
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  width: 172,
                                  height: 40,
                                  color: Colors.transparent,
                                ),
                              ),
                              // Semi-transparent overlay
                              Container(
                                padding: EdgeInsets.only(left: 18),
                                width: 172,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/icons/active/location.svg"),
                                    SizedBox(width: 8,),
                                    Text(
                                    'Telang Indah',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),

                        const Spacer(), // Untuk dorong container merah ke kanan

                        // Container merah di sebelah kanan
                        GestureDetector(
                          onTap: (){},
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              // Blur layer
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.transparent,
                                ),
                              ),
                              // Semi-transparent overlay
                              Container(
                                // padding: EdgeInsets.only(left: 18),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: SvgPicture.asset("assets/icons/nonactive/save.svg"),
                                )
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16, left: 8, right: 8),
              // color: Colors.green,
              width: double.maxFinite,
              height: 76,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w500
                    ),
                  ),
                  Text("By Agus Gacor",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8),
              // color: Colors.green,
              width: double.maxFinite,
              height: 45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rental Price",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(harga,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8),
              // color: Colors.green,
              width: double.maxFinite,
              height: 114,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(deskripsi,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  
                    ),
                    maxLines: 4,
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.maxFinite,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF060A56),
                  foregroundColor: Colors.white
                ),
                onPressed: (){},
                child: Text("chat owner", 
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
