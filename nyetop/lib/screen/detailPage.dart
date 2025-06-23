
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/wishlistbutton.dart';

class DetailPage extends StatelessWidget {
  final String nama;
  final String harga;
  final String deskripsi;
  final Widget? imageWidget;
  final String itemId;
  final String? imagePath;

  const DetailPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.imageWidget,
    required this.itemId,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          'Detail Laptop',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container with flexible height
              Container(
                constraints: const BoxConstraints(
                  minHeight: 300,
                  maxHeight: 410,
                ),
                padding: const EdgeInsets.all(12),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 22),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: imageWidget ?? Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image, size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Date badge
                    Container(
                      width: 104,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF060A56),
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
                    // Glassmorphism area with wishlist button
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        children: [
                          // Location container
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              clipBehavior: Clip.hardEdge,
                              child: Stack(
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 140,
                                        maxWidth: 180,
                                      ),
                                      height: 40,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    constraints: const BoxConstraints(
                                      minWidth: 140,
                                      maxWidth: 180,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/icons/active/location.svg"),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'Telang Indah',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Wishlist button with glassmorphism effect
                          WishlistButton(
                            itemId: itemId,
                            nama: nama,
                            harga: harga,
                            deskripsi: deskripsi,
                            imageWidget: imageWidget,
                            imagePath: imagePath ?? '',
                            isGlassmorphism: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              // Title section
              Container(
                margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w500
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By Agus Setiawan",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFA1A1A1),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Price section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF060A56).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Harga",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF060A56),
                            ),
                          ),
                          Text(
                            "Rp $harga",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF060A56),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Description section
                    Text(
                      "Deskripsi",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      deskripsi,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Specifications section
                    Text(
                      "Spesifikasi",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSpecificationItem("Processor", "Intel Core i5-12400H"),
                    _buildSpecificationItem("RAM", "16GB DDR4"),
                    _buildSpecificationItem("Storage", "512GB SSD"),
                    _buildSpecificationItem("Display", "15.6\" Full HD IPS"),
                    _buildSpecificationItem("Graphics", "Intel Iris Xe Graphics"),
                    _buildSpecificationItem("OS", "Windows 11 Home"),
                    
                    const SizedBox(height: 32),
                    
                    // Contact seller section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hubungi Penjual",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Agus Setiawan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Online 2 jam yang lalu",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF060A56),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Chat",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Wishlist button (alternative position)
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: WishlistButton(
                itemId: itemId,
                nama: nama,
                harga: harga,
                deskripsi: deskripsi,
                imageWidget: imageWidget,
                imagePath: imagePath ?? '',
                isGlassmorphism: false,
                size: 50,
              ),
            ),
            
            // Contact button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Implement contact functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menghubungi penjual...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A56),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Hubungi Penjual",
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
    );
  }

  Widget _buildSpecificationItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================
// 🔧 UPDATED CARD WIDGET
// ================================================

// widgets/card.dart (Updated dengan wishlist button)



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../widgets/wishlist_button.dart';
// import '../pages/detail_screen.dart';

// Widget cardLaptop({
//   required String judul,
//   required String harga,
//   required String deskripsi,
//   required Widget imageWidget,
//   String? itemId,
//   String? imagePath,
//   bool showWishlistButton = true,
// }) {
//   return Builder(
//     builder: (context) => GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DetailPage(
//               nama: judul,
//               harga: harga,
//               deskripsi: deskripsi,
//               imageWidget: imageWidget,
//               itemId: itemId ?? '',
//               imagePath: imagePath,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image container with wishlist button
//             Expanded(
//               flex: 3,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                       ),
//                       child: imageWidget,
//                     ),
//                   ),
//                   // Wishlist button
//                   if (showWishlistButton && itemId != null)
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: WishlistButton(
//                         itemId: itemId!,
//                         nama: judul,
//                         harga: harga,
//                         deskripsi: deskripsi,
//                         imageWidget: imageWidget,
//                         imagePath: imagePath ?? '',
//                         isGlassmorphism: true,
//                         size: 32,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
            
//             // Content
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       judul,
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Rp $harga",
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFF060A56),
//                       ),
//                     ),
//                     const Spacer(),
//                     Text(
//                       deskripsi,
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// // ================================================
// // 📱 MAIN APP INTEGRATION
// // ================================================

// // main.dart (Updated dengan Provider)
