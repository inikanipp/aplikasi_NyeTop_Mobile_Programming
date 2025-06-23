import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final String nama;
  final String harga;
  final String deskripsi;
  final Widget imageWidget;
  final String itemId;
  final String? imagePath;
  final String jenis;
  final String lokasi;
  final String user;
  final String imageId;
  final String sellerId;

  const DetailPage({
    Key? key,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.imageWidget,
    required this.itemId,
    this.imagePath,
    this.jenis = '',
    this.lokasi = '',
    this.user = '',
    this.imageId = '',
    this.sellerId = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Produk',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Produk
            Text(
              nama,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            
            // User/Penjual Info dengan FutureBuilder
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(sellerId.isNotEmpty ? sellerId : user)
                  .get(),
              builder: (context, snapshot) {
                String displayName = 'Memuat...';
                if (snapshot.hasData && snapshot.data!.exists) {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  displayName = userData['name'] ?? 'Anonim';
                } else if (snapshot.hasError || !snapshot.hasData) {
                  displayName = _getUserDisplayName();
                }
                
                return Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Dijual oleh $displayName',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),

            // Gambar Produk
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageWidget,
              ),
            ),
            const SizedBox(height: 20),

            // Harga
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF060A56).withOpacity(0.1),
                    const Color(0xFF060A56).withOpacity(0.05),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF060A56).withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Rp ${_formatHarga(harga)}',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF060A56),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profil Penjual Section
            _buildSectionTitle('Profil Penjual'),
            const SizedBox(height: 12),
            
            // SellerProfileWidget dengan data dari Firestore
            SellerProfileWidget(
              sellerId: sellerId.isNotEmpty ? sellerId : user,
              showContactButton: true,
              nama: nama,
              harga: harga,
            ),
            
            const SizedBox(height: 24),

            // Deskripsi
            _buildSectionTitle('Deskripsi'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                deskripsi.isNotEmpty ? deskripsi : 'Tidak ada deskripsi tersedia',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Informasi Tambahan
            if (jenis.isNotEmpty || lokasi.isNotEmpty) ...[
              _buildSectionTitle('Informasi Tambahan'),
              const SizedBox(height: 12),

              // Info Items
              if (jenis.isNotEmpty)
                _buildInfoItem('Jenis', jenis),
              if (lokasi.isNotEmpty)
                _buildInfoItem('Lokasi', lokasi),
              
              const SizedBox(height: 24),
            ],

            // Aksi Buttons
            _buildSectionTitle('Tertarik dengan produk ini?'),
            const SizedBox(height: 16),

            // Contact Buttons
            Row(
              children: [
                // Wishlist Button
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[300]!),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Add to wishlist functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text('Ditambahkan ke wishlist'),
                            ],
                          ),
                          backgroundColor: Colors.orange[600],
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.orange[600],
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Contact Button dengan WhatsApp
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(sellerId.isNotEmpty ? sellerId : user)
                        .get(),
                    builder: (context, snapshot) {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            final userData = snapshot.data!.data() as Map<String, dynamic>;
                            final phoneNumber = userData['phone'] ?? '';
                            final sellerName = userData['name'] ?? 'Penjual';
                            
                            if (phoneNumber.isNotEmpty) {
                              await _openWhatsApp(context, phoneNumber, sellerName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Nomor WhatsApp penjual tidak tersedia'),
                                  backgroundColor: Colors.red[600],
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Data penjual tidak ditemukan'),
                                backgroundColor: Colors.red[600],
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          'Hubungi Penjual',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF060A56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 56),
                          elevation: 2,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // FUNGSI WHATSAPP LANGSUNG
  Future<void> _openWhatsApp(BuildContext context, String phoneNumber, String sellerName) async {
    try {
      // Bersihkan nomor telepon
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      // Format nomor Indonesia
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62' + cleanPhone.substring(1);
      } else if (!cleanPhone.startsWith('62')) {
        cleanPhone = '62' + cleanPhone;
      }
      
      // Pesan untuk WhatsApp
      String message = 'Halo $sellerName, saya tertarik dengan produk "$nama" seharga Rp ${_formatHarga(harga)}. Apakah masih tersedia?';
      
      // URL WhatsApp - langsung ke wa.me (paling universal)
      final String whatsappUrl = 'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}';
      final Uri uri = Uri.parse(whatsappUrl);
      
      // Langsung launch tanpa pengecekan
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      
    } catch (e) {
      // Jika gagal, coba tanpa pesan
      try {
        String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
        if (cleanPhone.startsWith('0')) {
          cleanPhone = '62' + cleanPhone.substring(1);
        } else if (!cleanPhone.startsWith('62')) {
          cleanPhone = '62' + cleanPhone;
        }
        
        final Uri fallbackUri = Uri.parse('https://wa.me/$cleanPhone');
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        
      } catch (e2) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pastikan WhatsApp terinstall di ponsel Anda'),
              backgroundColor: Colors.red[600],
            ),
          );
        }
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUserDisplayName() {
    if (user.isNotEmpty) {
      if (user.contains('@')) {
        return user.split('@')[0];
      }
      if (user.length > 20) {
        return user.substring(0, 12) + '...';
      }
      return user;
    }
    return 'Anonim';
  }

  String _formatHarga(String harga) {
    try {
      int hargaInt = int.parse(harga);
      return hargaInt.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    } catch (e) {
      return harga;
    }
  }
}

// SellerProfileWidget yang diperbaiki
class SellerProfileWidget extends StatelessWidget {
  final String sellerId;
  final bool showContactButton;
  final String? nama;
  final String? harga;

  const SellerProfileWidget({
    Key? key,
    required this.sellerId,
    this.showContactButton = false,
    this.nama,
    this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(sellerId)
          .get(),
      builder: (context, snapshot) {
        String displayName = 'Memuat...';
        String phone = '';
        
        if (snapshot.hasData && snapshot.data!.exists) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          displayName = userData['name'] ?? 'Penjual';
          phone = userData['phone'] ?? '';
        } else if (snapshot.hasError || !snapshot.hasData) {
          displayName = _getSellerDisplayName(sellerId);
        }
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF060A56),
                child: Text(
                  _getInitials(displayName),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Seller Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.orange[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.8 (24 ulasan)',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Contact Button (optional)
              if (showContactButton && phone.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    await _openWhatsAppFromProfile(context, phone, displayName);
                  },
                  icon: Icon(
                    Icons.message,
                    color: const Color(0xFF060A56),
                    size: 20,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi WhatsApp dari profil - LANGSUNG
  Future<void> _openWhatsAppFromProfile(BuildContext context, String phoneNumber, String sellerName) async {
    try {
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62' + cleanPhone.substring(1);
      } else if (!cleanPhone.startsWith('62')) {
        cleanPhone = '62' + cleanPhone;
      }
      
      String message = 'Halo $sellerName, saya tertarik dengan produk yang Anda jual. Bisakah kita diskusi lebih lanjut?';
      
      if (nama != null && harga != null) {
        message = 'Halo $sellerName, saya tertarik dengan produk "$nama" seharga Rp ${_formatHarga(harga!)}. Bisakah kita diskusi?';
      }
      
      // Langsung ke wa.me
      final String whatsappUrl = 'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}';
      final Uri uri = Uri.parse(whatsappUrl);
      
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      
    } catch (e) {
      // Fallback tanpa pesan
      try {
        String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
        if (cleanPhone.startsWith('0')) {
          cleanPhone = '62' + cleanPhone.substring(1);
        } else if (!cleanPhone.startsWith('62')) {
          cleanPhone = '62' + cleanPhone;
        }
        
        final Uri fallbackUri = Uri.parse('https://wa.me/$cleanPhone');
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        
      } catch (e2) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pastikan WhatsApp terinstall'),
              backgroundColor: Colors.red[600],
            ),
          );
        }
      }
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty || name == 'Memuat...') return 'U';
    if (name.contains('@')) {
      name = name.split('@')[0];
    }
    List<String> words = name.split(' ');
    if (words.length >= 2) {
      return (words[0][0] + words[1][0]).toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _getSellerDisplayName(String sellerId) {
    if (sellerId.isEmpty) return 'Penjual';
    if (sellerId.contains('@')) {
      return sellerId.split('@')[0];
    }
    if (sellerId.length > 20) {
      return sellerId.substring(0, 15) + '...';
    }
    return sellerId;
  }

  String _formatHarga(String harga) {
    try {
      int hargaInt = int.parse(harga);
      return hargaInt.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    } catch (e) {
      return harga;
    }
  }
}