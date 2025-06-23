// widgets/wishlist_button.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/wishlist_provider.dart';
import '../model/wishlist_item.dart';

class WishlistButton extends StatelessWidget {
  final String itemId;
  final String nama;
  final String harga;
  final String deskripsi;
  final Widget? imageWidget;
  final String imagePath;
  final bool isGlassmorphism;
  final double size;
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
    this.isGlassmorphism = true,
    this.size = 40,
    this.kategori,
    this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isInWishlist = wishlistProvider.isInWishlist(itemId);
        
        return GestureDetector(
          onTap: () async {
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
                      ? '$nama dihapus dari wishlist'
                      : '$nama ditambahkan ke wishlist',
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: isInWishlist ? Colors.red : Colors.green,
                ),
              );
            }
          },
          child: _buildButton(isInWishlist),
        );
      },
    );
  }

  Widget _buildButton(bool isInWishlist) {
    if (isGlassmorphism) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: size,
                height: size,
                color: Colors.transparent,
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: isInWishlist 
                  ? Colors.amber.withOpacity(0.3)
                  : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.amber[700] : Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isInWishlist ? Colors.amber[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isInWishlist ? Colors.amber : Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border,
            color: isInWishlist ? Colors.amber[700] : Colors.grey[600],
            size: 20,
          ),
        ),
      );
    }
  }
}