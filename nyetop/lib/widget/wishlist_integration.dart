
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/wishlist_provider.dart';
import '../model/wishlist_item.dart';
import 'package:provider/provider.dart';

// Wishlist Badge for AppBar
class WishlistBadge extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;

  const WishlistBadge({
    super.key,
    this.iconColor,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wishlist');
              },
              icon: Icon(
                Icons.favorite,
                color: iconColor ?? const Color(0xFF060A56),
                size: iconSize,
              ),
            ),
            if (wishlistProvider.wishlistCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    '${wishlistProvider.wishlistCount}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Wishlist Button for DetailPage
class WishlistButton extends StatelessWidget {
  final String itemId;
  final String nama;
  final String harga;
  final String deskripsi;
  final Widget? imageWidget;
  final String imagePath;
  final String? kategori;
  final String? lokasi;

  const WishlistButton({
    super.key,
    required this.itemId,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    this.imageWidget,
    required this.imagePath,
    this.kategori,
    this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isInWishlist = wishlistProvider.isInWishlist(itemId);
        
        return ElevatedButton.icon(
          onPressed: () async {
            final wishlistItem = WishlistItem(
              id: itemId,
              nama: nama,
              harga: harga,
              deskripsi: deskripsi,
              imageWidget: imageWidget,
              imagePath: imagePath,
              kategori: kategori,
              lokasi: lokasi,
            );
            
            await wishlistProvider.toggleWishlist(wishlistItem);
            
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isInWishlist 
                      ? '$nama removed from wishlist'
                      : '$nama added to wishlist',
                    style: GoogleFonts.poppins(),
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: isInWishlist ? Colors.red : Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isInWishlist ? Colors.red : Colors.white,
            foregroundColor: isInWishlist ? Colors.white : Colors.red,
            side: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border,
            size: 20,
          ),
          label: Text(
            isInWishlist ? 'Saved' : 'Save to Wishlist',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}