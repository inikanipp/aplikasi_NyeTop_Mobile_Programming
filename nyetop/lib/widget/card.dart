// widgets/card.dart (Fixed - Mengatasi overflow issue)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/wishlistbutton.dart';
import '../screen/detail_screen.dart';

Widget cardLaptop({
  required String judul,
  required String harga,
  required String deskripsi,
  required Widget imageWidget,
  String? itemId,
  String? imagePath,
  bool showWishlistButton = true,
  Map<String, dynamic>? laptopData,
}) {
  return Builder(
    builder: (context) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              nama: judul,
              harga: harga,
              deskripsi: deskripsi,
              imageWidget: imageWidget,
              itemId: itemId ?? '',
              imagePath: imagePath,
              jenis: laptopData?['jenis'] ?? '',
              lokasi: laptopData?['lokasi'] ?? '',
              user: laptopData?['user'] ?? '',
              imageId: laptopData?['imageId'] ?? '',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container dengan aspect ratio tetap
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: imageWidget,
                    ),
                  ),
                  // Wishlist button
                  if (showWishlistButton && itemId != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: WishlistButton(
                        itemId: itemId!,
                        nama: judul,
                        harga: harga,
                        deskripsi: deskripsi,
                        imageWidget: imageWidget,
                        imagePath: imagePath ?? '',
                        isGlassmorphism: true,
                        size: 32,
                      ),
                    ),
                ],
              ),
            ),
            
            // Content area dengan constraint height yang lebih fleksibel
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Penting: ukuran minimum
                  children: [
                    // Judul dengan constraint yang ketat
                    Flexible(
                      child: Text(
                        judul,
                        style: GoogleFonts.poppins(
                          fontSize: 13, // Kurangi sedikit font size
                          fontWeight: FontWeight.w600,
                          height: 1.2, // Line height yang lebih kompak
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Harga
                    Text(
                      "Rp $harga",
                      style: GoogleFonts.poppins(
                        fontSize: 15, // Sedikit kurangi dari 16
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF060A56),
                        height: 1.1, // Line height kompak
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Deskripsi dengan Flexible untuk mencegah overflow
                    Flexible(
                      child: Text(
                        deskripsi,
                        style: GoogleFonts.poppins(
                          fontSize: 11, // Kurangi dari 12
                          color: Colors.grey[600],
                          height: 1.2, // Line height kompak
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Alternative: Versi dengan height yang lebih terkontrol
Widget cardLaptopFixed({
  required String judul,
  required String harga,
  required String deskripsi,
  required Widget imageWidget,
  String? itemId,
  String? imagePath,
  bool showWishlistButton = true,
  Map<String, dynamic>? laptopData,
}) {
  return Builder(
    builder: (context) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              nama: judul,
              harga: harga,
              deskripsi: deskripsi,
              imageWidget: imageWidget,
              itemId: itemId ?? '',
              imagePath: imagePath,
              jenis: laptopData?['jenis'] ?? '',
              lokasi: laptopData?['lokasi'] ?? '',
              user: laptopData?['user'] ?? '',
              imageId: laptopData?['imageId'] ?? '',
            ),
          ),
        );
      },
      child: Container(
        // Berikan height constraint yang jelas
        height: 280, // Atau sesuaikan dengan kebutuhan grid
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container - tinggi tetap
            SizedBox(
              height: 160, // Height tetap untuk gambar
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: imageWidget,
                    ),
                  ),
                  // Wishlist button
                  if (showWishlistButton && itemId != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: WishlistButton(
                        itemId: itemId!,
                        nama: judul,
                        harga: harga,
                        deskripsi: deskripsi,
                        imageWidget: imageWidget,
                        imagePath: imagePath ?? '',
                        isGlassmorphism: true,
                        size: 28, // Sedikit kecilkan button
                      ),
                    ),
                ],
              ),
            ),
            
            // Content area - tinggi terbatas
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10), // Kurangi padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Judul
                    Text(
                      judul,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 1, // Batasi hanya 1 baris
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Harga
                    Text(
                      "Rp $harga",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF060A56),
                        height: 1.1,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Deskripsi
                    Expanded(
                      child: Text(
                        deskripsi,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}